import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/models/fuel.dart';
import 'package:skysoft/models/info.dart';
import 'package:skysoft/models/invoice.dart';
import 'package:skysoft/providers/invoice_provider.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/invoice_widget.dart';
import 'package:skysoft/widgets/snackbars.dart';

class ViewInvoice extends StatelessWidget {
  final Invoice invoice;
  final Info info;
  final Fuel fuel;
  ViewInvoice(
      {Key? key, required this.invoice, required this.info, required this.fuel})
      : super(key: key);

  AppConfig? _ac;
  ScreenshotController screenshotController = ScreenshotController();

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
          "Invoice",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton:
          Consumer<InvoiceProvider>(builder: (context, provider, child) {
        return FloatingActionButton(
          onPressed: () async {
            Uint8List? img = await screenshotController.capture();
            var result = await context
                .read<InvoiceProvider>()
                .saveInvoice(image: img!, invoice: invoice);
            if (result["status"] == Status.SUCCESS) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      "Saved",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Color.fromRGBO(176, 35, 65, 1),
                      ),
                    ),
                    content: SizedBox(
                      height: 150,
                      child: Column(
                        children: [
                          const Text(
                            "Invoice has saved as an image into",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                            ),
                          ),
                          Text(
                            result["path"],
                            style: const TextStyle(
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"),
                      ),
                    ],
                  );
                },
              );
            } else {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(wrongSnackBar());
            }
          },
          child: provider.invoiceSaveStatus == Status.LOADING
              ? const CupertinoActivityIndicator()
              : const Icon(Icons.save),
          backgroundColor: const Color.fromRGBO(176, 35, 65, 1),
        );
      }),
      body: SizedBox(
        height: _ac!.rH(100),
        width: _ac!.rW(100),
        child: ListView(
          children: [
            Screenshot(
              controller: screenshotController,
              child: InvoiceWidget(
                branchName: info.arName,
                companyAddress: '',
                companyNameEN: info.company!.enName,
                companyNameAR: info.company!.arName,
                companyPhone:
                    'Phone : ${info.company!.phone}, LAN : ${info.company!.lanNo}',
                invoiceDate: DateFormat('dd-MM-yyyy')
                    .format(DateTime.parse(invoice.date!)),
                invoiceNumber: invoice.invoiceNo.toString(),
                item: fuel.name,
                measure: 'Litre',
                price: invoice.cash.toString(),
                quantity: invoice.qty.toString(),
                total: invoice.paidAmt.toString(),
                vatNumber: info.company!.vatNo,
                qrData: invoice.qrCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
