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
        Text(
          "$title",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: _ac!.rHP(0.5)),
        Container(
          width: _ac!.rW(100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: _ac!.rWP(3),
              right: _ac!.rWP(3),
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "$hint",
                hintStyle: TextStyle(
                  fontSize: 13,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[500],
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10)
              ),
            ),
          ),
        )
      ],
    );
  }
}
