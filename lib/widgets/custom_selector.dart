import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/widgets/selector_option.dart';

class CustomSelector extends StatefulWidget {
  final Function? onChange;
  CustomSelector({Key? key, this.onChange}) : super(key: key);

  @override
  _CustomSelectorState createState() => _CustomSelectorState();
}

class _CustomSelectorState extends State<CustomSelector> {
  AppConfig? _ac;

  int selectedIndex = 0;

  @override
  void initState() {
    widget.onChange!(0);
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
                SelectorOption(
                  title: "Petrol",
                  amount: 105,
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                      widget.onChange!(0);
                    });
                  },
                ),
                SelectorOption(
                  title: "Petrol",
                  amount: 95,
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                      widget.onChange!(1);
                    });
                  },
                ),
                SelectorOption(
                  title: "Diesel",
                  isSelected: selectedIndex == 2,
                  amount: 105,
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                      widget.onChange!(2);
                    });
                  },
                )
              ],
            )),
      ),
    );
  }
}
