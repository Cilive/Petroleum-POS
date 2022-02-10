import 'package:flutter/material.dart';
import 'package:skysoft/constants/colors.dart';

showResponseDialog(
    {required BuildContext context,
    required String title,
    required String content,
    bool forceQuit = false}) {
  showDialog(
    barrierDismissible: !forceQuit,
    context: context,
    builder: (context) {
      return AlertDialog(
    
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: "OpenSans",
            color:kPrimaryColor,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(
            fontFamily: "OpenSans",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (forceQuit) {
                Navigator.of(context).pop();
              }
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
