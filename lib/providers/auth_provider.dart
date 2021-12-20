import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:skysoft/services/pref_services.dart';
import 'package:skysoft/utils/enums.dart';

class AuthProvider extends ChangeNotifier {
  Api api = Api();
  PreferenceService prefService = PreferenceService();
  Status loginStatus = Status.IDLE;

  Future<Status> login(String username, String password) async {
    _setLoginStatus(Status.LOADING);
    try {
      http.Response response = await api.post(
        apiname: 'employee/login/',
        body: {'email': username, 'password': password},
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        await prefService
            .setPrefData(PrefData.fromJson(jsonDecode(response.body)));
        _setLoginStatus(Status.SUCCESS);
        print("SUCCESS");
      } else if (response.statusCode == 400) {
        _setLoginStatus(Status.FAILED);
        print("FAILED");
      } else {
        _setLoginStatus(Status.FAILED);
        print("SOMETHING WENT WRONG");
      }
      print(response.statusCode);
      print(response.body);
    } on TimeoutException catch (t) {
      _setLoginStatus(Status.TIMEOUT);
      print("Time Out");
    } catch (e) {
      _setLoginStatus(Status.FAILED);
      print("Exception : $e");
    }
    return loginStatus;
  }

  refreshToken() async {
    PrefData prefData = await prefService.getPrefData();
    try {
      http.Response response = await api.post(
        apiname: 'employee/login/refresh/',
        body: {'refresh': prefData.refresh},
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['access'];
        await prefService.setAccessToken(data);
        print("Token Refreshed");
      } else if (response.statusCode == 400) {
        print("FAILED");
      } else {
        print("SOMETHING WENT WRONG");
      }
      print(response.statusCode);
      print(response.body);
    } on TimeoutException catch (t) {
      print("Time Out");
    } catch (e) {
      print("Exception : $e");
    }
  }

  logout() {
    prefService.deletePrefData();
  }

  _setLoginStatus(Status status) {
    loginStatus = status;
    notifyListeners();
  }
}
