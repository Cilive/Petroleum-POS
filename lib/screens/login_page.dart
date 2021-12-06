import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/screens/home_page.dart';
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
          title: "Username",
          hint: "Enter username",
        ),
        SizedBox(height: _ac!.rHP(2)),
        CustomTextfield(
          title: "Password",
          hint: "Enter password",
        ),
        SizedBox(height: _ac!.rHP(2)),
        Spacer(),
        CustomButton(
          title: "Login",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
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
