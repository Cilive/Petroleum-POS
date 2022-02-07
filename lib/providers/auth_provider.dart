import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/strings.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:skysoft/services/intercepter.dart';
import 'package:skysoft/services/pref_services.dart';
import 'package:skysoft/utils/enums.dart';

class AuthProvider extends ChangeNotifier {
  Api api = Api();
  PreferenceService prefService = PreferenceService();
  Status loginStatus = Status.IDLE;
  Status otpSendStatus = Status.IDLE;
  Status forgotPasswordChangeStatus = Status.IDLE;
  Status changePasswordStatus = Status.IDLE;
  var dio = Dio();

  Future<Status> login(String username, String password) async {
    _setLoginStatus(Status.LOADING);
    try {
      http.Response response = await api.post(
        apiname: 'login/',
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

  Future<bool> refreshToken() async {
    PrefData prefData = await prefService.getPrefData();
    try {
      http.Response response = await api.post(
        apiname: 'refresh/',
        body: {'refresh': prefData.refresh},
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['access'];
        await prefService.setAccessToken(data);
        print("Token Refreshed");
        return true;
      } else if (response.statusCode == 400) {
        print("FAILED");
        return false;
      } else {
        print("SOMETHING WENT WRONG");
        return false;
      }
    } on TimeoutException catch (t) {
      print("Time Out");
      return false;
    } catch (e) {
      print("Exception : $e");
      return false;
    }
  }

  Future<Status> sendOTP({required String email}) async {
    _setOtpSendStatus(Status.LOADING);
    try {
      PrefData data = await prefService.getPrefData();
      http.Response response = await api
          .post(
            ///TODO: Remove [.localhost] from api name
            apiname: "administrator/forgot_password/",
            body: {
              'email': email,
            },
            isWithToken: false,
          )
          .timeout(const Duration(seconds: 10));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        _setOtpSendStatus(Status.SUCCESS);
      } else {
        _setOtpSendStatus(Status.FAILED);
      }
    } on TimeoutException catch (e) {
      _setOtpSendStatus(Status.TIMEOUT);
    } catch (e) {
      _setOtpSendStatus(Status.FAILED);
    }
    return otpSendStatus;
  }

  Future<Status> forgotPassword(
      {required String email,
      required String otp,
      required String password}) async {
    _setForgotPasswordChangeStatus(Status.LOADING);
    try {
      PrefData data = await prefService.getPrefData();
      http.Response response = await api
          .post(

              ///TODO: Remove [.localhost] from api name
              apiname: "administrator/change_password/",
              body: {
                "email": email,
                "otp": otp,
                "password": password,
              },
              isWithToken: false)
          .timeout(const Duration(seconds: 10));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        _setForgotPasswordChangeStatus(Status.SUCCESS);
      } else {
        _setForgotPasswordChangeStatus(Status.FAILED);
      }
    } on TimeoutException catch (e) {
      _setForgotPasswordChangeStatus(Status.TIMEOUT);
    } catch (e) {
      _setForgotPasswordChangeStatus(Status.FAILED);
    }
    _setOtpSendStatus(Status.IDLE);
    return forgotPasswordChangeStatus;
  }

  //Change Password
  changePassword({required String email, required String password}) async {
    print("change password");
    _setChangePasswordStatus(Status.LOADING);
    try {
      PrefData data = await prefService.getPrefData();
      dio.interceptors.add(AuthIntercepter());
      Response response = await dio.post(
        ///TODO: Remove [.localhost] from api name
        Strings.BASE_URL +
            "/clients/${data.empTenantName!.username}.localhost/employee/password_change/",
        data: {
          "email": email,
          "password": password,
        },
      ).timeout(const Duration(seconds: 10));
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 201) {
        _setChangePasswordStatus(Status.SUCCESS);
      } else {
        _setChangePasswordStatus(Status.FAILED);
      }
    } on TimeoutException catch (e) {
      _setChangePasswordStatus(Status.TIMEOUT);
    } catch (e) {
      print(e);
      _setChangePasswordStatus(Status.FAILED);
    }
    return changePasswordStatus;
  }

  logout() {
    prefService.deletePrefData();
  }

  _setOtpSendStatus(Status status) {
    otpSendStatus = status;
    notifyListeners();
  }

  _setForgotPasswordChangeStatus(Status status) {
    forgotPasswordChangeStatus = status;
    notifyListeners();
  }

  _setChangePasswordStatus(Status status) {
    changePasswordStatus = status;
    notifyListeners();
  }

  _setLoginStatus(Status status) {
    loginStatus = status;
    notifyListeners();
  }
}
