import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/screens/generate_invoice_page.dart';
import 'package:skysoft/widgets/dispenser_menu.dart';
import 'package:skysoft/widgets/home_menu.dart';

class DispenserHomePage extends StatefulWidget {
  const DispenserHomePage({Key? key}) : super(key: key);

  @override
  _DispenserHomePageState createState() => _DispenserHomePageState();
}

class _DispenserHomePageState extends State<DispenserHomePage> {
  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
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
      body: Container(
        child: _bodySection(),
      ),
    );
  }

  Widget _bodySection() {
    return Padding(
      padding: EdgeInsets.all(_ac!.rWP(5)),
      child: Container(
        child: GridView(
          gridDelegate: SliverGrid.count(
            crossAxisCount: 2,
            childAspectRatio: 5 / 2,
            crossAxisSpacing: _ac!.rWP(5),
            mainAxisSpacing: _ac!.rWP(5),
          ).gridDelegate,
          children: [
            DispenserMenu(
              title: "Dispenser 1",
              color: Color.fromRGBO(176, 35, 65, 1),
              icon: Icons.copy_all,
            ),
            DispenserMenu(
              title: "Dispenser 2",
              color: Color.fromRGBO(176, 35, 65, 1),
              icon: Icons.copy_all,
            ),
            DispenserMenu(
              title: "Dispenser 3",
              color: Color.fromRGBO(176, 35, 65, 1),
              icon: Icons.copy_all,
            ),
            DispenserMenu(
              title: "Dispenser 4",
              color: Color.fromRGBO(176, 35, 65, 1),
              icon: Icons.copy_all,
            )
          ],
        ),
      ),
    );
  }
}
