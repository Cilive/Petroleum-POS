import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final bool? isLoading;
  final bool? isEnabled;
  CustomButton(
      {Key? key,
      this.title,
      this.onTap,
      this.isLoading = false,
      this.isEnabled = true})
      : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return GestureDetector(
      onTap: () {
        if (!isLoading! && isEnabled!) {
          print("Clicked");
          onTap!();
        }
      },
      child: SizedBox(
        width: _ac!.rW(100),
        child: Center(
          child: Container(
            height: _ac!.rH(7),
            decoration: BoxDecoration(
              color: isLoading!
                  ? Colors.black12
                  : isEnabled! ? const Color.fromRGBO(176, 35, 65, 1) : Colors.grey,
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
