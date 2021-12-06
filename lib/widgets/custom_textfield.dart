import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';

class CustomTextfield extends StatelessWidget {
  final String? title;
  final String? hint;
  final Function? onChanged;
  final String? value;
  final TextEditingController? controller;

  CustomTextfield(
      {Key? key,
      this.title,
      this.hint,
      this.onChanged,
      this.value,
      this.controller})
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
            color: Color.fromRGBO(246, 246, 246, 1),
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
              controller: controller,
              decoration: InputDecoration(
                hintText: "$hint",
                hintStyle: TextStyle(
                  fontSize: 13,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(183, 183, 183, 1),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
          ),
        )
      ],
    );
  }
}
