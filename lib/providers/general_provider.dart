import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/strings.dart';
import 'package:skysoft/models/fuel.dart';
import 'package:skysoft/models/info.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/services/intercepter.dart';
import 'package:skysoft/services/pref_services.dart';

class GebneralProvider extends ChangeNotifier {
  //
  PreferenceService prefService = PreferenceService();
  Dio dio = Dio();
  Info? companyInfo;
  //
   getCompanyData() async {
    PrefData data = await prefService.getPrefData();
    dio.interceptors.add(AuthIntercepter());
    Response response = await dio
        .get(
          ///TODO: Remove [.localhost] from api name
          Strings.BASE_URL +
              "/clients/${data.empTenantName!.username}.localhost/employee/company_details/",
        )
        .timeout(const Duration(seconds: 10));
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['msg'] == 'Success') {
        companyInfo = Info.fromJson(response.data['data']);
        notifyListeners();
      }
    } else {
      //
    }
  }
}
