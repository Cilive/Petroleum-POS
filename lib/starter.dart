import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/colors.dart';
import 'package:skysoft/providers/starter_provider.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:provider/provider.dart';

// class Starter extends StatefulWidget {
//   const Starter({Key? key}) : super(key: key);

//   @override
//   _StarterState createState() => _StarterState();
// }

// class _StarterState extends State<Starter> {
//   Future<bool> checkLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? user_id = prefs.getString('username');

//     if (user_id == null) {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
//       var userLogin = await checkLogin();
//       print(userLogin);
//       if (userLogin) {
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) {
//           return const HomePage();
//         }));
//       } else {
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) {
//           return const LoginPage();
//         }));
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: kBackgroundColor,
//       body: Center(
//         child: CupertinoActivityIndicator(),
//       ),
//     );
//   }
// }

class Starter extends StatelessWidget {
  Starter({Key? key}) : super(key: key);

  StarterProvider? _starterProvider;

  @override
  Widget build(BuildContext context) {
    _starterProvider = StarterProvider(context: context);
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
