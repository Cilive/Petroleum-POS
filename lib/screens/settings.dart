import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/screens/generate_invoice_page.dart';
import 'package:skysoft/screens/login_page.dart';
import 'package:skysoft/widgets/home_menu.dart';

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
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
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
      child: Container(
        child: Column(
          children: [
            ListTile(
              title: Text("Language"),
              leading: Icon(Icons.language,color: Color.fromRGBO(176, 35, 65, 1)),
              onTap: () async {
                
              },
            ),
            ListTile(
              title: Text("Defualt Printer"),
              leading: Icon(Icons.print,color: Color.fromRGBO(176, 35, 65, 1)),
              onTap: () async {
                
              },
            ),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout,color: Color.fromRGBO(176, 35, 65, 1)),
              onTap: () async {
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (route) => false,
                );
              },
            ),
            Spacer(),
            Divider(),
            SizedBox(height: _ac!.rH(2)),
            Text(
              "2021 ForeTech.pw, All Right Reserved",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),
            SizedBox(height: _ac!.rH(2)),
          ],
        ),
      ),
    );
  }
}
