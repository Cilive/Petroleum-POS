import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skysoft/constants/colors.dart';
import 'package:skysoft/modules/home/home_page.dart';
import 'package:skysoft/modules/auth/auth_login.dart';

class Starter extends StatefulWidget {
  const Starter({Key? key}) : super(key: key);

  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('username');

    if (user_id == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var userLogin = await checkLogin();
      print(userLogin);
      if (userLogin) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const HomePage();
        }));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}