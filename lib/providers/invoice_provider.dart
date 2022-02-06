import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/strings.dart';
import 'package:skysoft/models/fuel.dart';
import 'package:skysoft/models/invoice.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/services/api_services.dart';
import 'package:skysoft/services/intercepter.dart';
import 'package:skysoft/services/pref_services.dart';
import 'package:http/http.dart' as http;
import 'package:skysoft/utils/enums.dart';

class InvoiceProvider extends ChangeNotifier {
  PreferenceService prefService = PreferenceService();
  Dio dio = Dio();
  Status invoiceDataStatus = Status.IDLE;
  List<Fuel> fuels = [];
  Status invoiceGenerateStatus = Status.IDLE;

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

  Future<Map> submitInvoice({
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
    try {
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
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['msg'] == 'Success') {
          Invoice invoice = Invoice.fromJson(response.data['data']);
          responseMessage = response.data['msg'];
          _setInvoiceGenerateStatus(Status.SUCCESS);
        } else {
          responseMessage = response.data['msg'];
          _setInvoiceGenerateStatus(Status.FAILED);
        }
      } else {
        responseMessage = "Something went wrong : ${response.statusCode}";
        _setInvoiceGenerateStatus(Status.FAILED);
      }
    } catch (e) {
      responseMessage = "Something went wrong";
      _setInvoiceGenerateStatus(Status.FAILED);
    }
    return {"status": invoiceGenerateStatus, "message": responseMessage};
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
