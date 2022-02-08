import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvoiceWidget extends StatelessWidget {
  final String? companyNameEN;
  final String? companyNameAR;
  final String? branchName;
  final String? companyAddress;
  final String? companyPhone;
  final String? invoiceNumber;
  final String? invoiceDate;
  final String? vatNumber;
  final String? quantity;
  final String? price;
  final String? measure;
  final String? total;
  final String? item;
  final String? qrData;
  InvoiceWidget(
      {Key? key,
      this.invoiceNumber,
      this.invoiceDate,
      this.vatNumber,
      this.quantity,
      this.price,
      this.measure,
      this.total,
      this.item,
      this.companyNameEN,
      this.companyAddress,
      this.companyPhone,
      this.companyNameAR,
      this.branchName,
      this.qrData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(builder: (context, constrains) {
        var _width = constrains.maxWidth;
        var _height = _width * 1.5;
        var _wp = _width / 100;
        var _hp = _height / 100;
        return Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black54, width: 1),
          ),
          child: Center(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: _wp * 5,
                    right: _wp * 5,
                    top: _hp * 5,
                    bottom: _hp * 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/invoice.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: _hp * 5,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: _hp * 6,
                  child: SizedBox(
                    width: _width,
                    child: Center(
                      child: Text(
                        '(فاتورة ضريبة القيمة المضافة)',
                        style: TextStyle(
                          fontSize: _hp * 2,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _hp * 10,
                  child: SizedBox(
                    width: _width,
                    child: Center(
                      child: Text(
                        '$companyNameAR',
                        style: TextStyle(
                          fontSize: _hp * 3.5,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _hp * 14,
                  child: SizedBox(
                    width: _width,
                    child: Center(
                      child: Text(
                        '$companyAddress',
                        style: TextStyle(
                          fontSize: _hp * 2.5,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _hp * 18,
                  child: SizedBox(
                    width: _width,
                    child: Center(
                      child: Text(
                        '$companyPhone',
                        style: TextStyle(
                            fontSize: _hp * 1.5,
                            fontWeight: FontWeight.w700,
                            fontFamily: "OpenSans"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   top: _hp * 20,
                //   child: SizedBox(
                //     width: _width,
                //     child: Center(
                //       child: Text(
                //         'أصلية',
                //         style: TextStyle(
                //           fontSize: _hp * 2.5,
                //           fontWeight: FontWeight.w700,
                //         ),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
                // ),
                Positioned(
                  top: _hp * 29,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: _wp * 5,
                      right: _wp * 5,
                    ),
                    child: SizedBox(
                      height: _hp * 21,
                      width: _width - _wp * 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '$invoiceNumber',
                                style: TextStyle(
                                  fontSize: _hp * 2.5,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                '$invoiceDate',
                                style: TextStyle(
                                  fontSize: _hp * 2.5,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                '$vatNumber',
                                style: TextStyle(
                                  fontSize: _hp * 2.5,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: _wp * 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                ':',
                                style: TextStyle(
                                  fontSize: _hp * 2.5,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                ':',
                                style: TextStyle(
                                  fontSize: _hp * 2.5,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                ':',
                                style: TextStyle(
                                  fontSize: _hp * 2.5,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: _wp * 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'رقم الفاتورة',
                                style: TextStyle(
                                  fontSize: _hp * 2.5,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                'التاريخ و الوقت',
                                style: TextStyle(
                                  fontSize: _hp * 2.5,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                'ظريبه الشراء',
                                style: TextStyle(
                                  fontSize: _hp * 2.5,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _hp * 50.5,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: _wp * 5,
                      right: _wp * 5,
                    ),
                    child: SizedBox(
                      width: _width - _wp * 10.5,
                      height: _hp * 4.5,
                      child: Padding(
                        padding: EdgeInsets.only(left: _wp, right: _wp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (_width - (_wp * 10)) / 5,
                              child: Text(
                                'مجموع',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: (_width - (_wp * 15)) / 5,
                              child: Text(
                                'السعر',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: (_width - (_wp * 15)) / 5,
                              child: Text(
                                'العنصر',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: (_width - (_wp * 15)) / 5,
                              child: Text(
                                'يقيس',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: (_width - (_wp * 15)) / 5,
                              child: Text(
                                'كمية',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _hp * 55.5,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: _wp * 5,
                      right: _wp * 5,
                    ),
                    child: SizedBox(
                      width: _width - _wp * 10.5,
                      height: _hp * 4.5,
                      child: Padding(
                        padding: EdgeInsets.only(left: _wp, right: _wp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (_width - (_wp * 10)) / 5,
                              child: Text(
                                '$total',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: (_width - (_wp * 15)) / 5,
                              child: Text(
                                '$price',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: (_width - (_wp * 15)) / 5,
                              child: Text(
                                '$item',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: (_width - (_wp * 15)) / 5,
                              child: Text(
                                '$measure',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: (_width - (_wp * 15)) / 5,
                              child: Text(
                                '$quantity',
                                style: TextStyle(
                                  fontSize: _hp * 2,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _hp * 67.5,
                  child: SizedBox(
                    width: _width,
                    child: Center(
                      child: Container(
                        height: _hp * 16,
                        width: _hp * 16,
                        color: Colors.black54,
                        child: QrImage(
                          data: qrData!,
                          version: QrVersions.auto,
                          size: _hp * 16,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _hp * 93,
                  child: SizedBox(
                    width: _width,
                    child: Center(
                      child: Text(
                        '$companyNameEN',
                        style: TextStyle(
                          fontSize: _hp * 2,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
