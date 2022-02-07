import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/models/dispenser.dart';
import 'package:skysoft/models/fuel.dart';
import 'package:skysoft/providers/dispenser_provider.dart';
import 'package:skysoft/providers/invoice_provider.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/custom_button.dart';
import 'package:skysoft/widgets/custom_selector.dart';
import 'package:skysoft/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:skysoft/widgets/snackbars.dart';
import 'package:skysoft/widgets/titled_textfield.dart';

class DispenserReadingPage extends StatefulWidget {
  final Dispenser? dispenser;
  const DispenserReadingPage({Key? key, this.dispenser}) : super(key: key);

  @override
  _DispenserReadingPageState createState() => _DispenserReadingPageState();
}

class _DispenserReadingPageState extends State<DispenserReadingPage> {
  TextEditingController startReading = TextEditingController();
  TextEditingController endReading = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController grossAmountController = TextEditingController();
  AppConfig? _ac;

  double qty = 0;
  double grossAmount = 0;
  double totalAmount = 0;
  double vatAmount = 0;
  Fuel? _selectedFuel;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      Status status = await context.read<InvoiceProvider>().getInvoiceData(
            dispenserId: widget.dispenser!.id.toString(),
          );
      if (status == Status.FAILED) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(wrongSnackBar());
      } else if (status == Status.TIMEOUT) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(timeoutSnackBar());
      }
      var prevReading =
          context.read<InvoiceProvider>().previouseDispenserReading;
        startReading.text = prevReading.toString();
      
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
          "Dispenser Reading",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<InvoiceProvider>(builder: (context, provider, child) {
          if (provider.invoiceDataStatus == Status.LOADING) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return _bodySection();
          }
        }),
      ),
    );
  }

  Widget _bodySection() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(_ac!.rWP(5)),
        child: SizedBox(
          height: _ac!.rH(85),
          width: _ac!.rW(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Fuel",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w700),
              ),
              CustomSelector(
                onChange: (Fuel val) {
                  setState(() {
                    _selectedFuel = val;
                  });
                  _calculateAmount();
                },
              ),
              SizedBox(height: _ac!.rHP(1)),
              const Text(
                "Start Reading",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w700),
              ),
              SizedBox(height: _ac!.rHP(0.5)),
              CustomTextfield(
                isEnabled: false,
                controller: startReading,
                hint: "Start Reading",
                onChanged: (val) {
                  _calculateAmount();
                },
              ),
              SizedBox(height: _ac!.rHP(2)),
              const Text(
                "End Reading",
                
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w700),
              ),
              SizedBox(height: _ac!.rHP(0.5)),
              CustomTextfield(
                controller: endReading,
                hint: "End Reading",
                type: TextInputType.number,
                onChanged: (val) {
                  _calculateAmount();
                },
              ),
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
              Consumer<DispenserProvider>(builder: (context, provider, child) {
                return CustomButton(
                  isLoading: provider.uploadReadingStatus == Status.LOADING,
                  title: "Submit",
                  onTap: () async {
                    Status result =
                        await context.read<DispenserProvider>().uploadReading(
                              payableAmount: totalAmount.toString(),
                              endReading: endReading.text,
                              startReading: startReading.text,
                              dispenserId: widget.dispenser!.id,
                              fuelId: _selectedFuel!.id,
                              fuelStock: _selectedFuel!.currentStock,
                            );
                    if (result == Status.SUCCESS) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Upload Success")),
                      );
                      Navigator.pop(context);
                    } else if (result == Status.TIMEOUT) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Session Timout!")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Somethig went wrong try agian")),
                      );
                    }
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  _calculateAmount() {
    if (_selectedFuel != null &&
        startReading.text.isNotEmpty &&
        endReading.text.isNotEmpty) {
      setState(() {
        qty = double.parse(startReading.text) - double.parse(endReading.text);
        grossAmount = qty * _selectedFuel!.rate!.toDouble();
        vatAmount = grossAmount * _selectedFuel!.fuelVat!.toDouble() / 100;
        totalAmount = grossAmount + vatAmount;
        grossAmountController.text = grossAmount.toString();
        totalAmountController.text = totalAmount.toString();
      });
    }
  }

  @override
  void dispose() {
    qty = 0;
    grossAmount = 0;
    totalAmount = 0;
    vatAmount = 0;
    startReading.dispose();
    endReading.dispose();
    grossAmountController.dispose();
    totalAmountController.dispose();

    super.dispose();
  }
}
