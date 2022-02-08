import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/custom_button.dart';
import 'package:skysoft/widgets/custom_textfield.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  AppConfig? _ac;
  TextEditingController emailController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
          "Change Password",
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
                controller: newpasswordController,
                hint: "Enter your new password",
                type: TextInputType.text,
              ),
              SizedBox(height: _ac!.rHP(2)),
              const Text(
                "Confirm Password",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: _ac!.rHP(0.5)),
              CustomTextfield(
                controller: confirmPasswordController,
                title: "Password",
                hint: "Confirm your password",
                type: TextInputType.text,
              ),
              const Spacer(),
              CustomButton(
                title: "Change Password",
                isLoading: provider.changePasswordStatus == Status.LOADING,
                onTap: () async {
                  print("Change Password");
                  if (emailController.text.isNotEmpty &&
                      newpasswordController.text.isNotEmpty &&
                      confirmPasswordController.text.isNotEmpty) {
                    if (newpasswordController.text ==
                        confirmPasswordController.text) {
                      var result = await provider.changePassword(
                          email: emailController.text,
                          password: newpasswordController.text);
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
                                "Password changed successfully",
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                ),
                              ),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
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
                                "An error occured while changing password",
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
                              "Password does not match",
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
                            "Please fill all the fields",
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
