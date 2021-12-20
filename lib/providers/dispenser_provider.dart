import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:skysoft/constants/strings.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/services/api_services.dart';
import 'package:skysoft/services/pref_services.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:http/http.dart' as http;

class DispenserProvider extends ChangeNotifier {
  PreferenceService prefService = PreferenceService();
  Api api = Api();
  Status uploadReadingStatus = Status.IDLE;
  var dio = Dio();
  AuthProvider _auth = AuthProvider();

  // Future<Status> uploadReading({
  //   String? startReading,
  //   String? endReading,
  //   String? amount,
  // }) async {
  //   _setUploadReadingStatus(Status.LOADING);
  //   try {
  //     Response response = await dio.post(
  //       Strings.BASE_URL + '/employee/meter_reading/',
  //       data: {
  //         'date': DateTime.now().toString(),
  //         'start_reading': startReading,
  //         'end_reading': endReading,
  //         'payable_amt': amount,
  //       },
  //     );
  //     print(response.data);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       _setUploadReadingStatus(Status.SUCCESS);
  //       print(response.data);
  //     } else {
  //       _setUploadReadingStatus(Status.FAILED);
  //     }

  //   } catch (e) {
  //     _setUploadReadingStatus(Status.FAILED);
  //     print("Exception : $e");
  //   }
  //   return uploadReadingStatus;
  // }

  bool isTokenExpired(String _token) {
    DateTime? expiryDate = Jwt.getExpiryDate(_token);
    bool isExpired = expiryDate!.compareTo(DateTime.now()) < 0;
    return isExpired;
  }

  Future<Status> uploadReading({
    String? startReading,
    String? endReading,
    String? amount,
  }) async {
    _setUploadReadingStatus(Status.LOADING);
    print(DateTime.now().toString());
    try {
      PrefData prefData = await prefService.getPrefData();
      if (isTokenExpired(prefData.access.toString())) {
        print("Token Expired");
        await _auth.refreshToken();
      }
      http.Response response = await api.post(
        apiname: 'employee/meter_reading/',
        body: {
          'date': DateTime.now().toString(),
          'start_reading': startReading,
          'end_reading': endReading,
          'payable_amt': amount,
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        _setUploadReadingStatus(Status.SUCCESS);
        print(response.body);
      } else {
        _setUploadReadingStatus(Status.FAILED);
      }
    } on TimeoutException {
      _setUploadReadingStatus(Status.TIMEOUT);
    } catch (e) {
      print(e);
      _setUploadReadingStatus(Status.FAILED);
    }
    return uploadReadingStatus;
  }

  _setUploadReadingStatus(Status status) {
    uploadReadingStatus = status;
    notifyListeners();
  }
}
