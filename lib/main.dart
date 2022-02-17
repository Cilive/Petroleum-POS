import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/constants/colors.dart';
import 'package:skysoft/constants/providers.dart';
import 'package:skysoft/starter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor
        ),
        title: 'SkySoft',
        home: Starter(),
      ),
    );
  }
}
