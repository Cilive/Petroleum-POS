import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/view/modules/auth/auth_login.dart';
import 'package:skysoft/view/modules/home/home_page.dart';

class StarterProvider extends ChangeNotifier {
  //
  StarterProvider({BuildContext? context}) {
    if (context != null) {
      initialiseStarterFunctions(context);
    }
  }
  //
  Status starterStatus = Status.IDLE;
  //
  Future<bool> checkUserAlreadyLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('username');
    if (user_id == null) {
      return false;
    } else {
      return true;
    }
  }

  initialiseStarterFunctions(BuildContext context) async {
    _setStarterStatus(Status.LOADING);
    await Future.delayed(const Duration(seconds: 2));
    var userLogin = await checkUserAlreadyLoggedIn();
    _setStarterStatus(Status.SUCCESS);
    print("User Login Status : $userLogin");
    if (userLogin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }));
    }
  }

  _setStarterStatus(Status status) {
    starterStatus = status;
    notifyListeners();
  }
}
