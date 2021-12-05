import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';

class DropdownWidget extends StatelessWidget {
  final String? title;
  final List? items;
  final Function? onChanged;
  final String? value;

  DropdownWidget({Key? key, this.title, this.items, this.onChanged, this.value}) : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: _ac!.rHP(0.5)),
        Container(
          width: _ac!.rW(100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: _ac!.rWP(3),
              right: _ac!.rWP(3),
            ),
            child: DropdownButtonFormField(
              items: [],
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        )
      ],
    );
  }
}
