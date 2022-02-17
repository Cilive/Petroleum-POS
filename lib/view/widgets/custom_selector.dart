import 'package:flutter/material.dart';
import 'package:skysoft/utils/config.dart';
import 'package:skysoft/models/fuel.dart';
import 'package:skysoft/providers/invoice_provider.dart';
import 'package:skysoft/view/widgets/selector_option.dart';
import 'package:provider/provider.dart';

class CustomSelector extends StatefulWidget {
  final Function? onChange;
  const CustomSelector({Key? key, this.onChange}) : super(key: key);

  @override
  _CustomSelectorState createState() => _CustomSelectorState();
}

class _CustomSelectorState extends State<CustomSelector> {
  AppConfig? _ac;

  int selectedIndex = 0;

  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
  );

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      List<Fuel> fuels = context.read<InvoiceProvider>().fuels;
      if (fuels.isNotEmpty) {
        widget.onChange!(fuels[0]);
      }
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return SizedBox(
      width: _ac!.rW(100),
      height: 90,
      child: Center(
        child: Consumer<InvoiceProvider>(builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
            ),
            child: ListView.builder(
              physics: const PageScrollPhysics(),
              itemCount: provider.fuels.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SelectorOption(
                  amount: provider.fuels[index].rate.toString(),
                  title: provider.fuels[index].name,
                  isSelected: index == selectedIndex,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onChange!(provider.fuels[index]);
                  },
                );
              },
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SelectorOption(
            //       title: "Petrol",
            //       amount: 95,
            //       isSelected: selectedIndex == 1,
            //       onTap: () {
            //         setState(() {
            //           selectedIndex = 1;
            //           widget.onChange!(1);
            //         });
            //       },
            //     ),
            //     SelectorOption(
            //       title: "Diesel",
            //       isSelected: selectedIndex == 2,
            //       amount: 105,
            //       onTap: () {
            //         setState(() {
            //           selectedIndex = 2;
            //           widget.onChange!(2);
            //         });
            //       },
            //     )
            //   ],
            // ),
          );
        }),
      ),
    );
  }
}
