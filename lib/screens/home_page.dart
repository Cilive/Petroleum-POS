import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/widgets/home_menu.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Home"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(40, 150, 209, 1),
              Color.fromRGBO(158, 218, 219, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _bodySection(),
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
            childAspectRatio: 4/3,
            crossAxisSpacing: _ac!.rWP(4),
            mainAxisSpacing: _ac!.rWP(4),
          ).gridDelegate,
          children: [
            HomeMenu(
              title: "Generate\nInvoice",
              icon: Icons.print_outlined,
              onTap:(){},
            ),
            HomeMenu(
              title: "Dispenser\nReading",
              icon: Icons.copy_all,
              onTap:(){},
            ),
          ],
        ),
      ),
    );
  }
}
