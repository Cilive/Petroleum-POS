import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';

class DispenserMenu extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? color;

  DispenserMenu({Key? key, this.title, this.icon, this.onTap, this.color})
      : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(_ac!.rWP(3)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: _ac!.rH(5),
                    width: _ac!.rH(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Icon(
                      icon,
                      size: _ac!.rH(3),
                      color: color,
                    ),
                  ),
                ],
              ),
              SizedBox(width: _ac!.rWP(2)),
              Text(
                "$title",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.white,
                    fontSize: _ac!.rWP(3.5),
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
