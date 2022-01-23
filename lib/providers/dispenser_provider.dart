import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:skysoft/constants/strings.dart';
import 'package:skysoft/models/dispenser.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/services/api_services.dart';
import 'package:skysoft/services/intercepter.dart';
import 'package:skysoft/services/pref_services.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:http/http.dart' as http;

class DispenserProvider extends ChangeNotifier {
  PreferenceService prefService = PreferenceService();
  Status uploadReadingStatus = Status.IDLE;
  var dio = Dio();
  final AuthProvider _auth = AuthProvider();
  List<Dispenser> dispensers = [];
  Status dispensersStatus = Status.IDLE;

  Future<Status> getDispensers() async {
    dispensers = [];
    _setDispensersStatus(Status.LOADING);
    try {
      PrefData data = await prefService.getPrefData();
      dio.interceptors.add(AuthIntercepter());
      Response response = await dio
          .get(
            ///TODO: Remove [.localhost] from api name
            Strings.BASE_URL +
                "/clients/${data.empTenantName!.username}.localhost/employee/dispencer/",
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        if (response.data['msg'] == 'Success') {
          List tmp = response.data['data'];
          for (var element in tmp) {
            Dispenser dispenser = Dispenser.fromJson(element);
            dispensers.add(dispenser);
          }
          _setDispensersStatus(Status.SUCCESS);
        } else {
          _setDispensersStatus(Status.FAILED);
        }
      } else {
        _setDispensersStatus(Status.FAILED);
      }
    } on TimeoutException catch (e) {
      _setDispensersStatus(Status.TIMEOUT);
    } catch (e) {
      _setDispensersStatus(Status.FAILED);
      log("Exception : $e");
    }
    return dispensersStatus;
  }

  Future<Status> uploadReading({
    String? startReading,
    String? endReading,
    String? amount,
  }) async {
    _setUploadReadingStatus(Status.LOADING);
    try {
      PrefData data = await prefService.getPrefData();
      dio.interceptors.add(AuthIntercepter());
      Response response = await dio.post(
        ///TODO: Remove [.localhost] from api name
        Strings.BASE_URL +
            "/clients/${data.empTenantName!.username}.localhost/employee/meterreading/",
        data: {
          'date': DateTime.now().toString(),
          'start_reading': startReading,
          'end_reading': endReading,
          'payable_amt': amount,
          "dispence": 2
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 201) {
        _setUploadReadingStatus(Status.SUCCESS);
      } else {
        _setUploadReadingStatus(Status.FAILED);
      }
    } on TimeoutException catch (e) {
      _setDispensersStatus(Status.TIMEOUT);
    } catch (e) {
      _setUploadReadingStatus(Status.FAILED);
      log("Exception : $e");
    }
    return uploadReadingStatus;
  }

  _setUploadReadingStatus(Status status) {
    uploadReadingStatus = status;
    notifyListeners();
  }

  _setDispensersStatus(Status status) {
    dispensersStatus = status;
    notifyListeners();
  }
}
