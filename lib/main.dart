import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/providers/dispenser_provider.dart';
import 'package:skysoft/providers/invoice_provider.dart';
import 'package:skysoft/screens/home_page.dart';
import 'package:skysoft/screens/login_page.dart';
import 'package:skysoft/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => InvoiceProvider()),
        ChangeNotifierProvider(create: (_) => DispenserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(176, 35, 65, 1)
        ),
        title: 'SkySoft',
        home: Splash(),
      ),
    );
  }
}
