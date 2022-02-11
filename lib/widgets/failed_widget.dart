import 'package:flutter/material.dart';
import 'package:skysoft/constants/colors.dart';

class FailedWidget extends StatelessWidget {
  final BuildContext context;
  final VoidCallback? onRetry;
  const FailedWidget(
    this.context, {
    Key? key,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Failed to load"),
          const Text("Something went wrong, Please try again"),
          IconButton(
            onPressed: () {
              onRetry!();
            },
            icon: const Icon(
              Icons.refresh,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
