import 'package:flutter/material.dart';
import 'package:skysoft/utils/config.dart';

class DropdownWidget extends StatelessWidget {
  final String? title;
  final List? items;
  final Function? onChanged;
  final String? value;

  DropdownWidget({Key? key, this.title, this.items, this.onChanged, this.value})
      : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: _ac!.rW(100),
          decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: _ac!.rWP(4),
              right: _ac!.rWP(3),
              top: _ac!.rHP(1),
              bottom: _ac!.rHP(1),
            ),
            child: DropdownButtonFormField(
              items: [],
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "$title",
                  hintStyle: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(183, 183, 183, 1),
                  ),
                  contentPadding: EdgeInsets.only(bottom: _ac!.rHP(1))),
            ),
          ),
        )
      ],
    );
  }
}
