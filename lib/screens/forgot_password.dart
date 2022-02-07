import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
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
                isEnabled: provider.forgotPasswordChangeStatus != Status.LOADING,
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
                            title: const Text("OTP sent"),
                            content: const Text(
                                "An OTP has been sent to your email. Please enter the OTP to change your password"),
                            actions: [
                              FlatButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
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
                            title: const Text("Error"),
                            content: const Text(
                                "An error occurred while sending OTP. Please try again"),
                            actions: [
                              FlatButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter email address"),
                      ),
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
                isLoading: provider.forgotPasswordChangeStatus == Status.LOADING,
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
                      //show success snackbar and exit
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password changed successfully"),
                        ),
                      );
                      Navigator.of(context).pop();
                    }else{
                      //show error snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("An error occurred while changing password"),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter OTP and password"),
                      ),
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
