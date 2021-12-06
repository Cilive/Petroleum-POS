import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  CustomButton({Key? key, this.title, this.onTap}) : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        width: _ac!.rW(100),
        child: Center(
          child: Container(
            height: _ac!.rH(7),
            decoration: BoxDecoration(
              color: Color.fromRGBO(176, 35, 65, 1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Text(
                "$title",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
