import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/constants/colors.dart';
import 'package:skysoft/utils/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/custom_button.dart';
import 'package:skysoft/widgets/custom_textfield.dart';
import 'package:skysoft/utils/dialogs.dart';

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
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kPrimaryTextColor),
        title: const Text(
          "Change Password",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: kPrimaryTextColor,
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
                        showResponseDialog(
                          context: context,
                          title: "Success",
                          content: "Password changed successfully",
                          forceQuit: true,
                        );
                      } else {
                        showResponseDialog(
                          context: context,
                          title: "Error",
                          content: "An error occured while changing password",
                        );
                      }
                    } else {
                      showResponseDialog(
                        context: context,
                        title: "Error",
                        content: "Password does not match",
                      );
                    }
                  } else {
                    showResponseDialog(
                      context: context,
                      title: "Error",
                      content: "Please fill all the fields",
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
                        color: kSecondaryColor,
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
