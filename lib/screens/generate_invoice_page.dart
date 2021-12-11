import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/widgets/counter_widget.dart';
import 'package:skysoft/widgets/custom_button.dart';
import 'package:skysoft/widgets/custom_selector.dart';
import 'package:skysoft/widgets/custom_textfield.dart';
import 'package:skysoft/widgets/titled_textfield.dart';

class GenerateInvoicePage extends StatefulWidget {
  const GenerateInvoicePage({Key? key}) : super(key: key);

  @override
  _GenerateInvoicePageState createState() => _GenerateInvoicePageState();
}

class _GenerateInvoicePageState extends State<GenerateInvoicePage> {
  AppConfig? _ac;
  int liter = 1;
  double amount = 0;

  int petrolOne = 100;
  int petrolTwo = 95;
  int diesel = 105;

  int selectedItem = 0;

  TextEditingController literController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    literController.text = liter.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          "Generate Invoice",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          height: _ac!.rH(100),
          width: _ac!.rW(100),
          child: Padding(
            padding: EdgeInsets.all(_ac!.rWP(5)),
            child: Column(
              children: [
                CustomTextfield(
                  hint: "Employee ID",
                ),
                SizedBox(height: _ac!.rHP(1)),
                CustomSelector(
                  onChange: (val) {
                    WidgetsBinding.instance!
                        .addPostFrameCallback((timeStamp) {
                          setState(() {
                      if (val == 0) {
                        selectedItem = petrolOne;
                      } else if (val == 1) {
                        selectedItem = petrolTwo;
                      } else {
                        selectedItem = diesel;
                      }
                    });
                    _calculateTotalAmount();
                        });
                  },
                ),
                Spacer(),
                CounterWidget(
                  controller: literController,
                  onIncrement: () {
                    literController.text =
                        (int.parse(literController.text) + 1).toString();
                    _calculateTotalAmount();
                  },
                  onDecrement: () {
                    if (int.parse(literController.text) != 0) {
                      literController.text =
                          (int.parse(literController.text) - 1).toString();
                      _calculateTotalAmount();
                    }
                  },
                ),
                Spacer(),
                TitledTextfield(
                  controller: amountController,
                ),
                SizedBox(height: _ac!.rHP(1)),
                CustomButton(
                  title: "Print Recipt",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _calculateTotalAmount() {
    print("Calculated");
    amountController.text =
        (selectedItem * int.parse(literController.text)).toString();
    print(selectedItem.toString());
  }
}