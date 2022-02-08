import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/screens/login_page.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/custom_button.dart';
import 'package:skysoft/widgets/custom_textfield.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  AppConfig? _ac;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(176, 35, 65, 1),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
          height: _ac!.rH(100),
          width: _ac!.rW(100),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), child: _bodySection())),
    );
  }

  Widget _bodySection() {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return SizedBox(
        height: _ac!.rH(90),
        width: _ac!.rW(100),
        child: Padding(
          padding: EdgeInsets.all(_ac!.rWP(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _ac!.rHP(2)),
              const Text(
                "Email",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: _ac!.rHP(0.5)),
              CustomTextfield(
                controller: emailController,
                hint: "Enter your email",
                type: TextInputType.emailAddress,
              ),
              SizedBox(height: _ac!.rHP(1)),
              CustomButton(
                title: "Send OTP",
                isEnabled:
                    provider.forgotPasswordChangeStatus != Status.LOADING,
                isLoading: provider.otpSendStatus == Status.LOADING,
                onTap: () async {
                  if (emailController.text.isNotEmpty) {
                    var result =
                        await provider.sendOTP(email: emailController.text);
                    if (result == Status.SUCCESS) {
                      //show success alert dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Success",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Color.fromRGBO(176, 35, 65, 1),
                              ),
                            ),
                            content: const Text(
                              "OTP has been sent to your email, please check your email and enter the OTP",
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
                      //show error alert dialog
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
                              "An error occured while sending OTP, please try again",
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
                    }
                  } else {
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
                            "Please enter email address",
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
                  }
                },
              ),
              const Spacer(),
              const Text(
                "OTP",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: _ac!.rHP(0.5)),
              CustomTextfield(
                controller: otpController,
                hint: "Enter OTP sent to your email",
                type: TextInputType.number,
              ),
              SizedBox(height: _ac!.rHP(2)),
              const Text(
                "New Password",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: _ac!.rHP(0.5)),
              CustomTextfield(
                controller: passwordController,
                hint: "Enter your new password",
                type: TextInputType.text,
              ),
              SizedBox(height: _ac!.rHP(1)),
              CustomButton(
                title: "Change Password",
                isLoading:
                    provider.forgotPasswordChangeStatus == Status.LOADING,
                isEnabled: provider.otpSendStatus == Status.SUCCESS,
                onTap: () async {
                  print("Change Password");
                  if (otpController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    var result = await provider.forgotPassword(
                        email: emailController.text,
                        otp: otpController.text,
                        password: passwordController.text);
                    if (result == Status.SUCCESS) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Success",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Color.fromRGBO(176, 35, 65, 1),
                              ),
                            ),
                            content: const Text(
                              "Password has been changed successfully",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                              ),
                            ),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                      (route) => false);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      //show error snackbar
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
                              "An error occured while changing password, please try again",
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
                    }
                  } else {
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
                            "Please enter OTP and new password",
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
                  }
                },
              ),
              const Divider(),
              SizedBox(
                width: _ac!.rW(100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: _ac!.rH(2)),
                    const Text(
                      "2021 ForeTech.pw, All Right Reserved",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: _ac!.rH(2)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
