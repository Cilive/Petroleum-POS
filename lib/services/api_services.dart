import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skysoft/constants/strings.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/services/pref_services.dart';

class Api {
  PreferenceService prefService = PreferenceService();

  Future<http.Response> get(String? apiname) async {
    http.Response response = await http.get(
      Uri.parse("${Strings.BASE_URL}/$apiname"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(Duration(seconds: 30));
    return response;
  }

  Future<http.Response> post({String? apiname, Object? body}) async {
    PrefData data = await prefService.getPrefData();
    print(Uri.parse("${Strings.BASE_URL}/$apiname"));
    http.Response response = await http
        .post(Uri.parse("${Strings.BASE_URL}/$apiname"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${data.access}'
            },
            body: jsonEncode(body))
        .timeout(Duration(seconds: 30));
    return response;
  }
}
