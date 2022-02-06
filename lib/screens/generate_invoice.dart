import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/models/fuel.dart';
import 'package:skysoft/providers/invoice_provider.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/custom_button.dart';
import 'package:skysoft/widgets/custom_selector.dart';
import 'package:skysoft/widgets/custom_textfield.dart';
import 'package:skysoft/widgets/snackbars.dart';
import 'package:skysoft/widgets/titled_textfield.dart';
import 'package:provider/provider.dart';

class GenerateInvoicePage extends StatefulWidget {
  const GenerateInvoicePage({Key? key}) : super(key: key);

  @override
  _GenerateInvoicePageState createState() => _GenerateInvoicePageState();
}

class _GenerateInvoicePageState extends State<GenerateInvoicePage> {
  AppConfig? _ac;
  double qty = 0;
  double grossAmount = 0;
  double totalAmount = 0;
  double vatAmount = 0;
  Fuel? _selectedFuel;

  int selectedItem = 0;

  TextEditingController qtyController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController grossAmountController = TextEditingController();

  @override
  void initState() {
    qtyController.text = qty.toString();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      Status status = await context.read<InvoiceProvider>().getInvoiceData();
      if (status == Status.FAILED) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(wrongSnackBar());
      } else if (status == Status.TIMEOUT) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(timeoutSnackBar());
      }
    });
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
        title: const Text(
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
        child: Consumer<InvoiceProvider>(builder: (context, provider, child) {
          if (provider.invoiceDataStatus == Status.LOADING) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return _bodyWidget();
          }
        }),
      ),
    );
  }

  Widget _bodyWidget() {
    return SizedBox(
      height: _ac!.rH(100),
      width: _ac!.rW(100),
      child: Padding(
        padding: EdgeInsets.all(_ac!.rWP(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _ac!.rHP(1)),
            Consumer<InvoiceProvider>(builder: (context, provider, child) {
              return CustomSelector(
                onChange: (Fuel val) {
                  setState(() {
                    _selectedFuel = val;
                  });
                  _calculateAmount();
                },
              );
            }),
            const Spacer(),
            const Padding(
              padding:  EdgeInsets.only(left: 2.0),
              child: Text(
                "Quantity (Ltr)",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
             SizedBox(height: _ac!.rHP(0.5)),
            CustomTextfield(
                type: TextInputType.number,
                hint: "Quantity in Liters",
                controller: qtyController,
                onChanged: (val) {
                  _calculateAmount();
                }),
            // CounterWidget(
            //   controller: literController,
            //   onIncrement: () {
            //     literController.text =
            //         (int.parse(literController.text) + 1).toString();
            //     _calculateTotalAmount();
            //   },
            //   onDecrement: () {
            //     if (int.parse(literController.text) != 0) {
            //       literController.text =
            //           (int.parse(literController.text) - 1).toString();
            //       _calculateTotalAmount();
            //     }
            //   },
            // ),
            const Spacer(),
            TitledTextfield(
              title: "Gross Amount : ",
              controller: grossAmountController,
              editable: false,
            ),
            TitledTextfield(
              title: "Total Amount : ",
              controller: totalAmountController,
              editable: false,
            ),
            SizedBox(height: _ac!.rHP(1)),
            Consumer<InvoiceProvider>(builder: (context, provider, child) {
              return CustomButton(
                title: "Submit",
                isLoading: provider.invoiceGenerateStatus == Status.LOADING,
                onTap: () async {
                  var paymentType = await _selectPaymentType();
                  provider.submitInvoice(
                    qty: qty.toString(),
                    fuelId: _selectedFuel!.id!,
                    paymentType: paymentType,
                    type: 2,
                    grossAmount: grossAmount.toString(),
                    vatAmount: vatAmount.toString(),
                    totalAmount: totalAmount.toString(),
                    paidAmount: totalAmount.toString(),
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }

  //select payment type is online or offline from dilaog
  Future<int> _selectPaymentType() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Payment Type"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: const Icon(Icons.wifi_tethering),
                  title: const Text("Online Payment"),
                  onTap: () {
                    Navigator.pop(context, 2);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text("Offline Payment"),
                  onTap: () {
                    Navigator.pop(context, 1);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _calculateAmount() {
    if (_selectedFuel != null) {
      setState(() {
        if (qtyController.text.toString() == '') {
          qty = 0;
        } else {
          qty = double.parse(qtyController.text);
        }
        grossAmount = qty * _selectedFuel!.rate!.toDouble();
        vatAmount = grossAmount * _selectedFuel!.fuelVat!.toDouble() / 100;
        totalAmount = grossAmount + vatAmount;
        grossAmountController.text = grossAmount.toString();
        totalAmountController.text = totalAmount.toString();
      });
    }
  }
}
