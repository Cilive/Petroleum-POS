import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';

class SelectorOption extends StatelessWidget {
  final String? title;
  final int? amount;
  final VoidCallback? onTap;
  final Color? color;
  final bool? isSelected;
  SelectorOption({Key? key, this.title, this.onTap, this.color, this.amount, this.isSelected})
      : super(key: key);

  AppConfig? _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        height: _ac!.rH(10),
        width: _ac!.rH(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: isSelected! ? Colors.grey[500] : Colors.white,
          border: Border.all(color: isSelected! ? Colors.white : Colors.black87)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$title",
              style: _textStyle(),
            ),
            Text(
              "$amount",
              style: _textStyle(),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      fontSize: 14,
      fontFamily: "OpenSans",
      fontWeight: FontWeight.w700,
      color: isSelected! ? Colors.white : Colors.black87,
    );
  }
}
