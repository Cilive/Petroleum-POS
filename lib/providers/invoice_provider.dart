import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skysoft/constants/strings.dart';
import 'package:skysoft/models/fuel.dart';
import 'package:skysoft/models/invoice.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/providers/general_provider.dart';
import 'package:skysoft/services/intercepter.dart';
import 'package:skysoft/services/pref_services.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:provider/provider.dart';

class InvoiceProvider extends ChangeNotifier {
  PreferenceService prefService = PreferenceService();
  Dio dio = Dio();
  Status invoiceDataStatus = Status.IDLE;
  List<Fuel> fuels = [];
  Status invoiceGenerateStatus = Status.IDLE;
  Status invoiceSaveStatus = Status.IDLE;

  Future<Status> getInvoiceData() async {
    _setInvoiceDataStatus(Status.LOADING);
    try {
      await _getFuelData();
      _setInvoiceDataStatus(Status.SUCCESS);
    } on TimeoutException catch (e) {
      _setInvoiceDataStatus(Status.TIMEOUT);
    } catch (e) {
      _setInvoiceDataStatus(Status.FAILED);
      print(e);
    }
    return invoiceDataStatus;
  }

  _getFuelData() async {
    fuels = [];
    PrefData data = await prefService.getPrefData();
    dio.interceptors.add(AuthIntercepter());
    Response response = await dio
        .get(
          ///TODO: Remove [.localhost] from api name
          Strings.BASE_URL +
              "/clients/${data.empTenantName!.username}.localhost/employee/fuel/",
        )
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      if (response.data['msg'] == 'Success') {
        List tmp = response.data['data'];
        for (var element in tmp) {
          Fuel fuel = Fuel.fromJson(element);
          fuels.add(fuel);
        }
      }
    } else {
      //
    }
  }

  Future<Map> submitInvoice(
    BuildContext context, {
    required String qty,
    required int fuelId,
    required int paymentType,
    required int type,
    required String grossAmount,
    required String vatAmount,
    required String totalAmount,
    required String paidAmount,
  }) async {
    _setInvoiceGenerateStatus(Status.LOADING);
    String responseMessage = '';
    Invoice invoice = Invoice();
    // try {
    PrefData data = await prefService.getPrefData();
    dio.interceptors.add(AuthIntercepter());
    Response response = await dio.post(
      ///TODO: Remove [.localhost] from api name
      Strings.BASE_URL +
          "/clients/${data.empTenantName!.username}.localhost/employee/generateinvoice/",
      data: {
        'qty': qty,
        'fuel': fuelId,
        'payment_type': paymentType,
        'type': type,
        'gross_amt': grossAmount,
        'vat_amount': vatAmount,
        'total_amt': totalAmount,
        'paid_amt': paidAmount,
      },
    ).timeout(const Duration(seconds: 10));
    print(response.data["msg"]);
    if (response.statusCode == 201) {
      if (response.data['msg'].toString() == 'Success') {
        invoice = Invoice.fromJson(response.data['data']);
        responseMessage = response.data['msg'];
        await context.read<GebneralProvider>().getCompanyData();
        _setInvoiceGenerateStatus(Status.SUCCESS);
      } else {
        responseMessage = response.data['msg'];
        _setInvoiceGenerateStatus(Status.FAILED);
      }
    } else {
      responseMessage = "Something went wrong : ${response.statusCode}";
      _setInvoiceGenerateStatus(Status.FAILED);
    }
    // } catch (e) {
    //   responseMessage = "Something went wrong : ${e.toString()}";
    //   _setInvoiceGenerateStatus(Status.FAILED);
    // }
    return {
      "status": invoiceGenerateStatus,
      "message": responseMessage,
      "invoice": invoice
    };
  }

  Future<Map> saveInvoice(
      {required Uint8List image, required Invoice invoice}) async {
    _setInvoiceSaveStatus(Status.LOADING);
    var path = "";
    try {
      final dirPath = await getExternalStorageDirectory();
      final file = await File(
              '${dirPath!.path}/${invoice.invoiceNo}-${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}.png')
          .create();
      await file.writeAsBytes(image);
      path = file.path.toString();
      _setInvoiceSaveStatus(Status.SUCCESS);
    } catch (e) {
      _setInvoiceSaveStatus(Status.FAILED);
    }
    return {"status" : invoiceSaveStatus, "path" : path };
  }

  _setInvoiceSaveStatus(Status status) {
    invoiceSaveStatus = status;
    notifyListeners();
  }

  _setInvoiceGenerateStatus(Status status) {
    invoiceGenerateStatus = status;
    notifyListeners();
  }

  _setInvoiceDataStatus(Status status) {
    invoiceDataStatus = status;
    notifyListeners();
  }
}
