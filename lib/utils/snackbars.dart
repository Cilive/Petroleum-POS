import 'package:flutter/material.dart';

SnackBar wrongSnackBar() {
  return const SnackBar(
    content: Text("Something went wrong"),
  );
}

SnackBar timeoutSnackBar() {
  return const SnackBar(
    content: Text("Session timed out, Try again"),
  );
}
