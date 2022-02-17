import 'package:flutter/material.dart';
import 'package:skysoft/constants/colors.dart';

class TimeoutWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final BuildContext context;
  const TimeoutWidget(
    this.context, {
    Key? key,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Time out"),
          const Text("Session timeout, please try again"),
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
