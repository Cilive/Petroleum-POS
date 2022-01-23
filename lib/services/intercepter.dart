import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/services/pref_services.dart';

class AuthIntercepter extends Interceptor {
  static bool isRetryCall = false;
  PreferenceService prefService = PreferenceService();
  AuthProvider _authProvider = AuthProvider();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    PrefData prefData = await prefService.getPrefData();
    bool _token = isTokenExpired(prefData.access.toString());
    bool _refresh = isTokenExpired(prefData.refresh.toString());
    bool _refreshed = true;

    print("Interceptor Called");

    if (_refresh) {
      _authProvider.logout();
      DioError? _error;
      handler.reject(_error!);
    } else if (_token) {
      _refreshed = await _authProvider.refreshToken();
    }
    if (_refreshed) {
      PrefData prefData = await prefService.getPrefData();
      options.headers['Authorization'] = "Bearer " + prefData.access.toString();
      options.headers['Accept'] = "application/json";
      handler.next(options);
    }

  }


  bool isTokenExpired(String _token) {
    DateTime? expiryDate = Jwt.getExpiryDate(_token);
    bool isExpired = expiryDate!.compareTo(DateTime.now()) < 0;
    return isExpired;
  }
}
