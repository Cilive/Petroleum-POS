import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/screens/change_password.dart';
import 'package:skysoft/screens/forgot_password.dart';
import 'package:skysoft/screens/login_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      body: Container(
        child: _bodySection(),
      ),
    );
  }

  Widget _bodySection() {
    return Padding(
      padding: EdgeInsets.all(_ac!.rWP(5)),
      child: Column(
        children: [
          ListTile(
            title: const Text("Language"),
            leading: const Icon(Icons.language,color: Color.fromRGBO(176, 35, 65, 1)),
            onTap: () async {
              
            },
          ),
          ListTile(
            title: const Text("Defualt Printer"),
            leading: const Icon(Icons.print,color: Color.fromRGBO(176, 35, 65, 1)),
            onTap: () async {
              
            },
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout,color: Color.fromRGBO(176, 35, 65, 1)),
            onTap: () async {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text("Change Password"),
            leading: const Icon(Icons.lock,color: Color.fromRGBO(176, 35, 65, 1)),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ChangePassword(),
                ),
              );
            },
          ),
          const Spacer(),
          const Divider(),
          SizedBox(height: _ac!.rH(2)),
          const Text(
            "2021 ForeTech.pw, All Right Reserved",
            style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w600,
                color: Colors.grey),
          ),
          SizedBox(height: _ac!.rH(2)),
        ],
      ),
    );
  }
}
