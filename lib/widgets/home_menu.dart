import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';

class HomeMenu extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;

  HomeMenu({Key? key, this.title, this.icon, this.onTap}) : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(_ac!.rWP(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: _ac!.rH(6),
                width: _ac!.rH(6),
                child: Icon(
                  icon,
                  size: _ac!.rH(6),
                ),
              ),
              Text(
                "$title",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: _ac!.rWP(4),
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
