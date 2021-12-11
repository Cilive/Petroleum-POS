import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:skysoft/services/pref_services.dart';

class AuthProvider extends ChangeNotifier {
  Api api = Api();
  PreferenceService prefService = PreferenceService();

  login(String username, String password) async {
    try {
      http.Response response = await api.post(
        apiname: 'employee/login/',
        body: {'email': username, 'password': password},
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        await prefService
            .setPrefData(PrefData.fromJson(jsonDecode(response.body)));
        print("SUCCESS");
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
}
