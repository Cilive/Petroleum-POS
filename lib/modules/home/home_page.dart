import 'package:flutter/material.dart';
import 'package:skysoft/constants/colors.dart';
import 'package:skysoft/utils/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/modules/dispenser/dispenser_home.dart';
import 'package:skysoft/modules/invoice/invoice_generation.dart';
import 'package:skysoft/modules/settings/settings.dart';
import 'package:skysoft/widgets/home_menu.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return WillPopScope(
      onWillPop: () async {
        var val = await _onWillPop();
        return val!;
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: kPrimaryTextColor),
          title: const Text(
            "Home",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w700,
              color: kPrimaryTextColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: kPrimaryTextColor,
              ),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          child: _bodySection(),
        ),
      ),
    );
  }

  Widget _bodySection() {
    return Padding(
      padding: EdgeInsets.all(_ac!.rWP(4)),
      child: GridView(
        gridDelegate: SliverGrid.count(
          crossAxisCount: 2,
          childAspectRatio: _ac!.rH(2.5) / _ac!.rW(5.6),
          crossAxisSpacing: _ac!.rWP(5),
          mainAxisSpacing: _ac!.rWP(5),
        ).gridDelegate,
        children: [
          HomeMenu(
            title: "Generate\nInvoice",
            icon: Icons.print_outlined,
            color: kPrimaryColor,
            onTap: () async {
              // await context.read<AuthProvider>().refreshToken();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GenerateInvoicePage(),
                ),
              );
            },
          ),
          HomeMenu(
            title: "Dispenser\nReading",
            icon: Icons.copy_all,
            color: kPrimaryColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DispenserHomePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  //Confirm do you want to exit dialog
  Future<bool?> _onWillPop() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Are you sure?',
            style: TextStyle(
              fontFamily: "OpenSans",
              color: kPrimaryColor,
            ),
          ),
          content: const Text('Do you want to exit an App'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
