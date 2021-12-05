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
        height: 40,
        child: Center(
          child: Container(
            width: _ac!.rW(35),
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(158, 218, 219, 1),
                  Colors.white
                  // Color.fromRGBO(158, 218, 219, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                "$title",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
