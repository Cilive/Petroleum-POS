import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/strings.dart';
import 'package:skysoft/models/fuel.dart';
import 'package:skysoft/models/pref_data.dart';
import 'package:skysoft/services/intercepter.dart';
import 'package:skysoft/services/pref_services.dart';

class GebneralProvider extends ChangeNotifier {
  //
  PreferenceService prefService = PreferenceService();
  Dio dio = Dio();
  //
  
}
