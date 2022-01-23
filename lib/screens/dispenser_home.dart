import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/dispenser_provider.dart';
import 'package:skysoft/screens/dispenser_reading.dart';
import 'package:skysoft/screens/generate_invoice_page.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/dispenser_menu.dart';
import 'package:skysoft/widgets/home_menu.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/widgets/snackbars.dart';

class DispenserHomePage extends StatefulWidget {
  const DispenserHomePage({Key? key}) : super(key: key);

  @override
  _DispenserHomePageState createState() => _DispenserHomePageState();
}

class _DispenserHomePageState extends State<DispenserHomePage> {
  AppConfig? _ac;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      Status status = await context.read<DispenserProvider>().getDispensers();
      if (status == Status.FAILED) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(wrongSnackBar());
      } else if (status == Status.TIMEOUT) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(timeoutSnackBar());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: const Text(
          "Dispenser Home",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Consumer<DispenserProvider>(builder: (context, provider, child) {
        if (provider.dispensersStatus == Status.LOADING) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return Container(
            child: _bodySection(),
          );
        }
      }),
    );
  }

  Widget _bodySection() {
    return Padding(
      padding: EdgeInsets.all(_ac!.rWP(5)),
      child: Container(
        child: Consumer<DispenserProvider>(builder: (context, provider, child) {
          return GridView.builder(
            itemCount: provider.dispensers.length,
            gridDelegate: SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 5 / 2,
              crossAxisSpacing: _ac!.rWP(5),
              mainAxisSpacing: _ac!.rWP(5),
            ).gridDelegate,
            itemBuilder: (context, index) {
              return DispenserMenu(
                color: const Color.fromRGBO(176, 35, 65, 1),
                icon: Icons.copy_all,
                title: provider.dispensers[index].name,
              );
            },
            // children: [
            //   DispenserMenu(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => DispenserReadingPage(),
            //         ),
            //       );
            //     },
            //     title: "Dispenser 1",
            //     color: const Color.fromRGBO(176, 35, 65, 1),
            //     icon: Icons.copy_all,
            //   ),
            //   DispenserMenu(
            //     title: "Dispenser 2",
            //     color: const Color.fromRGBO(176, 35, 65, 1),
            //     icon: Icons.copy_all,
            //   ),
            //   DispenserMenu(
            //     title: "Dispenser 3",
            //     color: Color.fromRGBO(176, 35, 65, 1),
            //     icon: Icons.copy_all,
            //   ),
            //   DispenserMenu(
            //     title: "Dispenser 4",
            //     color: Color.fromRGBO(176, 35, 65, 1),
            //     icon: Icons.copy_all,
            //   )
            // ],
          );
        }),
      ),
    );
  }
}
