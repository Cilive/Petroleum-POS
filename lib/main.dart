import 'package:flutter/material.dart';
import 'package:skysoft/screens/home_page.dart';
import 'package:skysoft/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkySoft',
      home: const LoginPage(),
    );
  }
}
