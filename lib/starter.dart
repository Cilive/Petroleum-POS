import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/colors.dart';
import 'package:skysoft/providers/starter_provider.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:provider/provider.dart';

class Starter extends StatelessWidget {
  const Starter({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Consumer<StarterProvider>(builder: (context, provider, child) {
        if (provider.starterStatus == Status.LOADING) {
          print("Loading");
          return const Center(
            child: SizedBox(
              child: CupertinoActivityIndicator(),
            ),
          );
        } else if (provider.starterStatus == Status.FAILED) {
          return Center(
            child: Column(
              children: [
                const Text("Somrthing went wrong"),
                const Text("Please retry or logout"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.logout,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: SizedBox(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      }),
    );
  }
}
