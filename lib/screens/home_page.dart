import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/screens/generate_invoice_page.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.black87,
              ))
        ],
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
            childAspectRatio: _ac!.rH(2.5) / _ac!.rW(5.5),
            crossAxisSpacing: _ac!.rWP(5),
            mainAxisSpacing: _ac!.rWP(5),
          ).gridDelegate,
          children: [
            HomeMenu(
              title: "Generate\nInvoice",
              icon: Icons.print_outlined,
              color: Color.fromRGBO(153, 213, 243, 1),
              onTap: () {
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
              color: Color.fromRGBO(248, 190, 127, 1),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
