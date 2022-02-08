import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/models/fuel.dart';
import 'package:skysoft/models/info.dart';
import 'package:skysoft/models/invoice.dart';
import 'package:skysoft/providers/general_provider.dart';
import 'package:skysoft/providers/invoice_provider.dart';
import 'package:skysoft/screens/view_invoice.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/custom_button.dart';
import 'package:skysoft/widgets/custom_selector.dart';
import 'package:skysoft/widgets/custom_textfield.dart';
import 'package:skysoft/widgets/dialogs.dart';
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
        backgroundColor: const Color.fromRGBO(176, 35, 65, 1),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Generate Invoice",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.white,
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
            const Text(
              "Select Fuel",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: _ac!.rHP(0.5)),
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
            SizedBox(height: _ac!.rHP(2)),
            const Text(
              "Quantity (Ltr)",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: _ac!.rHP(1)),
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
                  //check if fuel is selected
                  if (_selectedFuel == null) {
                    showResponseDialog(
                      context: context,
                      title: "Error",
                      content: "Please select fuel",
                    );
                    return;
                  }

                  print(qtyController.text);

                  //check if quantity is entered
                  if (qtyController.text == 0.0.toString()) {
                    showResponseDialog(
                      context: context,
                      title: "Error",
                      content: "Please enter Quantity filed",
                    );
                    return;
                  }

                  var paymentType = await _selectPaymentType();
                  var result = await provider.submitInvoice(
                    context,
                    qty: qty.toString(),
                    fuelId: _selectedFuel!.id!,
                    paymentType: paymentType,
                    type: 2,
                    grossAmount: grossAmount.toString(),
                    vatAmount: vatAmount.toString(),
                    totalAmount: totalAmount.toString(),
                    paidAmount: totalAmount.toString(),
                  );
                  print(result);
                  if (result['status'] == Status.SUCCESS) {
                    Invoice invoice = result["invoice"];
                    Info? info = context.read<GebneralProvider>().companyInfo;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewInvoice(
                          invoice: invoice,
                          info: info!,
                          fuel: _selectedFuel!,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result['message']),
                      ),
                    );
                  }
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
