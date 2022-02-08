import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/screens/forgot_password.dart';
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
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
        ),
      ),
    );
  }

  Widget _pageSection() {
    return Padding(
      padding: EdgeInsets.all(_ac!.rWP(6)),
      child: SizedBox(
        height: _ac!.rH(40),
        width: _ac!.rW(100),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            // _firstPage(),
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
        const Spacer(),
        DropdownWidget(
          title: "Select Language",
        ),
        const Spacer(),
        CustomButton(
          title: "Next",
          onTap: () {
            _pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 500),
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgotPassword()));
          },
          child: const Text("Forgot Password?"),
        ),
        const Spacer(),
        Consumer<AuthProvider>(builder: (context, provider, child) {
          return CustomButton(
            title: "Login",
            isLoading: provider.loginStatus == Status.LOADING,
            onTap: () async {
              //validate username and password
              if (_username.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        "Error",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: Color.fromRGBO(176, 35, 65, 1),
                        ),
                      ),
                      content: const Text(
                        "Username is required",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                        ),
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              } else if (_password.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        "Error",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: Color.fromRGBO(176, 35, 65, 1),
                        ),
                      ),
                      content: const Text(
                        "Password is required",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                        ),
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                Status result =
                    await provider.login(_username.text, _password.text);
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
                    const SnackBar(content: Text("Session Timout!")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Somethig went wrong try agian")),
                  );
                }
              }
            },
          );
        })
      ],
    );
  }

  Widget _logoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: _ac!.rH(15),
          width: _ac!.rH(20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/logo.png"),
            ),
          ),
        ),
        Text(
          "SkySoft",
          style: TextStyle(
              fontFamily: "OpenSans",
              fontSize: _ac!.rHP(5),
              fontWeight: FontWeight.w900,
              color: const Color.fromRGBO(176, 35, 65, 1)),
        )
      ],
    );
  }
}
