import 'package:flutter/material.dart';
import 'package:skysoft/utils/config.dart';

class HomeMenu extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? color;

  HomeMenu({Key? key, this.title, this.icon, this.onTap, this.color})
      : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(_ac!.rWP(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: _ac!.rHP(1)),
              Text(
                "$title",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans",
                    fontSize: _ac!.rWP(4.5),
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                width: _ac!.rW(10),
                child: const Divider(
                  thickness: 3,
                  color: Colors.white30,
                ),
              ),
              SizedBox(height: _ac!.rHP(1)),
              Row(
                children: const [
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
