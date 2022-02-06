import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';

class TitledTextfield extends StatelessWidget {
  final String? title;
  final String? hint;
  final Function? onChanged;
  final String? value;
  final bool editable;
  final TextEditingController? controller;

  TitledTextfield(
      {Key? key,
      this.title,
      this.hint,
      this.onChanged,
      this.value,
      this.controller, this.editable = true})
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
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: _ac!.rWP(5),
              right: _ac!.rWP(5),
              top: _ac!.rHP(1),
              bottom: _ac!.rHP(1),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: _ac!.rW(50),
                  child: Text(
                    "$title",
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(183, 183, 183, 1),
                    ),
                  ),
                ),
                SizedBox(
                  width: _ac!.rW(30),
                  height: _ac!.rH(6),
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(176, 35, 65, 1),
                    ),
                    textAlign: TextAlign.end,
                    controller: controller,
                    decoration: InputDecoration(
                      enabled: editable,
                      hintText: "0.00",
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(176, 35, 65, 1),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
