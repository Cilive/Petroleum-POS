import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/screens/home_page.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/custom_button.dart';
import 'package:skysoft/widgets/custom_textfield.dart';
import 'package:skysoft/widgets/dropdown_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PageController _pageController = PageController(initialPage: 0);
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: _ac!.rH(100),
          width: _ac!.rW(100),
          child: Column(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: _ac!.rH(10)),
                    _logoSection(),
                    SizedBox(height: _ac!.rH(5)),
                    _pageSection(),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    )
                  ],
                ),
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
      ),
    );
  }

  Widget _pageSection() {
    return Padding(
      padding: EdgeInsets.all(_ac!.rWP(6)),
      child: Container(
        height: _ac!.rH(40),
        width: _ac!.rW(100),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            _firstPage(),
            _secondPage(),
          ],
        ),
      ),
    );
  }

  Widget _firstPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownWidget(
          title: "Select Language",
        ),
        SizedBox(height: _ac!.rHP(2)),
        DropdownWidget(
          title: "Select Your Pumb",
        ),
        SizedBox(height: _ac!.rHP(2)),
        Text("Forgot Password?"),
        Spacer(),
        CustomButton(
          title: "Next",
          onTap: () {
            _pageController.animateToPage(
              1,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        )
      ],
    );
  }

  Widget _secondPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextfield(
          controller: _username,
          title: "Username",
          hint: "Enter username",
        ),
        SizedBox(height: _ac!.rHP(2)),
        CustomTextfield(
          controller: _password,
          title: "Password",
          hint: "Enter password",
        ),
        SizedBox(height: _ac!.rHP(2)),
        Spacer(),
        Consumer<AuthProvider>(
          builder: (context, provider, child) {
            if (provider.loginStatus == Status.LOADING) {
              return Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CupertinoActivityIndicator(),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(height: 40),
        CustomButton(
          title: "Login",
          onTap: () async {
            Status result =
                await Provider.of<AuthProvider>(context, listen: false)
                    .login(_username.text, _password.text);
            if (result == Status.SUCCESS) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
                (route) => false,
              );
            } else if (result == Status.TIMEOUT) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Session Timout!")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Somethig went wrong try agian")),
              );
            }
          },
        )
      ],
    );
  }

  Widget _logoSection() {
    return Container(
      height: _ac!.rH(20),
      width: _ac!.rH(20),
      color: Colors.grey,
    );
  }
}
