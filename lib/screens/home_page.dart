import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/screens/dispenser_home.dart';
import 'package:skysoft/screens/generate_invoice.dart';
import 'package:skysoft/screens/settings.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(176, 35, 65, 1),
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Home",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
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
      child: Container(
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
              color: const Color.fromRGBO(176, 35, 65, 1),
              onTap: () async {
                // await context.read<AuthProvider>().refreshToken();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenerateInvoicePage(),
                  ),
                );
              },
            ),
            HomeMenu(
              title: "Dispenser\nReading",
              icon: Icons.copy_all,
              color: Color.fromRGBO(176, 35, 65, 1),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DispenserHomePage(),
                  ),
                );
              },
            ),
          ],
        ),
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
              color: Color.fromRGBO(176, 35, 65, 1),
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
