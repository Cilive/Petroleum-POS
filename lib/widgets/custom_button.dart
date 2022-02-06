import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final bool? isLoading;
  CustomButton({Key? key, this.title, this.onTap, this.isLoading = false})
      : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return GestureDetector(
      onTap: () {
        if (!isLoading!) {
          onTap!();
        }
      },
      child: SizedBox(
        width: _ac!.rW(100),
        child: Center(
          child: Container(
            height: _ac!.rH(7),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(176, 35, 65, 1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: isLoading!
                  ? const CupertinoActivityIndicator()
                  : Text(
                      "$title",
                      style: const TextStyle(
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
