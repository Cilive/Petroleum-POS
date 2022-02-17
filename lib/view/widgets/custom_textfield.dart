import 'package:flutter/material.dart';
import 'package:skysoft/constants/colors.dart';
import 'package:skysoft/utils/config.dart';

class CustomTextfield extends StatelessWidget {
  final String? title;
  final String? hint;
  final Function? onChanged;
  final String? value;
  final TextInputType type;
  final bool isEnabled;
  final TextEditingController? controller;

  CustomTextfield(
      {Key? key,
      this.title,
      this.hint,
      this.onChanged,
      this.value,
      this.controller,
      this.type = TextInputType.text, this.isEnabled = true})
      : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: _ac!.rW(100),
          decoration: BoxDecoration(
            color: kSecondaryLiteColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: _ac!.rWP(3),
              right: _ac!.rWP(3),
              top: _ac!.rHP(1),
              bottom: _ac!.rHP(1),
            ),
            child: TextFormField(
              onChanged: (val) {
                onChanged!(val);
              },
              enabled: isEnabled,
              controller: controller,
              obscureText: title == "Password",
              keyboardType: type,
              decoration: InputDecoration(
                hintText: "$hint",
                hintStyle: const TextStyle(
                  fontSize: 13,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                  color: kSecondaryColor,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 10),
              ),
            ),
          ),
        )
      ],
    );
  }
}
