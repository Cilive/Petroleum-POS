import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/strings.dart';
import 'package:skysoft/models/fuel.dart';
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

  _setInvoiceDataStatus(Status status) {
    invoiceDataStatus = status;
    notifyListeners();
  }
}
