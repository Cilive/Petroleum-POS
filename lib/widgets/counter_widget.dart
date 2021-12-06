import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/widgets/selector_option.dart';

class CounterWidget extends StatefulWidget {
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final TextEditingController? controller;

  CounterWidget({Key? key, this.onIncrement, this.controller, this.onDecrement})
      : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  AppConfig? _ac;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Container(
      width: _ac!.rW(100),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _roundedButton(
                icon: Icons.remove,
                onTap: () {
                  widget.onDecrement!();
                },
              ),
              Container(
                width: _ac!.rW(30),
                height: _ac!.rH(6),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(176, 35, 65, 1),
                  ),
                  textAlign: TextAlign.center,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: "00",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(176, 35, 65, 1),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
              _roundedButton(
                icon: Icons.add,
                onTap: () {
                  widget.onIncrement!();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundedButton({IconData? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: CircleAvatar(
        backgroundColor: Color.fromRGBO(176, 35, 65, 1),
        radius: _ac!.rWP(6),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
