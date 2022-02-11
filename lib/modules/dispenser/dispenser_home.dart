import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/colors.dart';
import 'package:skysoft/utils/config.dart';
import 'package:skysoft/providers/dispenser_provider.dart';
import 'package:skysoft/modules/dispenser/dispenser_reading.dart';
import 'package:skysoft/utils/dialogs.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/dispenser_menu.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/utils/snackbars.dart';

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
        showResponseDialog(
          context: context,
          title: "Error",
          content: "Something went wrong, please try again.",
        );
      } else if (status == Status.TIMEOUT) {
        Navigator.pop(context);
        showResponseDialog(
          context: context,
          title: "Oops",
          content: "Session Timeout!",
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kPrimaryTextColor),
        title: const Text(
          "Dispenser Home",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: kPrimaryTextColor,
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
              color: kPrimaryColor,
              icon: Icons.copy_all,
              title: provider.dispensers[index].name,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DispenserReadingPage(
                      dispenser: provider.dispensers[index],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
