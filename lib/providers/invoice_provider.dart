import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skysoft/services/api_services.dart';
import 'package:skysoft/services/pref_services.dart';
import 'package:http/http.dart' as http;
import 'package:skysoft/utils/enums.dart';

class InvoiceProvider extends ChangeNotifier {
  PreferenceService prefService = PreferenceService();
  Api api = Api();
  Status getAmountStatus = Status.IDLE;

  getAmount() async {
    _setGetAmountStatus(Status.LOADING);
    try {
      http.Response response = await api.get('get_amount/');
      if (response.statusCode == 200) {
        _setGetAmountStatus(Status.SUCCESS);
      } else {
        _setGetAmountStatus(Status.FAILED);
      }
    } on TimeoutException {
      _setGetAmountStatus(Status.TIMEOUT);
    } catch (e) {
      _setGetAmountStatus(Status.FAILED);
    }
  }

  _setGetAmountStatus(Status status) {
    getAmountStatus = status;
    notifyListeners();
  }
}
