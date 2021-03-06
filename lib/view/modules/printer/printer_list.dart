import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:intl/intl.dart';
import 'package:skysoft/constants/colors.dart';
import 'package:skysoft/utils/config.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/services.dart';

class PrinterList extends StatefulWidget {
  const PrinterList({Key? key}) : super(key: key);

  @override
  _PrinterListState createState() => _PrinterListState();
}

class _PrinterListState extends State<PrinterList> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String? _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;
  AppConfig? _ac;

  void initPrinter() {
    print('init printer');

    printerManager.startScan(const Duration(seconds: 2));
    printerManager.scanResults.listen((event) {
      print(event);
      if (!mounted) return;
      setState(() => _devices = event);

      if (_devices.isEmpty) {
        setState(() {
          _devicesMsg = 'No devices';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bluetoothManager.state.listen((val) {
      print("state = $val");
      if (!mounted) return;
      if (val == 12) {
        print('on');
        initPrinter();
      } else if (val == 10) {
        print('off');
        setState(() {
          _devicesMsg = 'Please enable bluetooth to print';
        });
      }
      print('state is $val');
    });
  }

  void _stopScanDevices() {
    printerManager.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              initPrinter();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kPrimaryTextColor),
        title: const Text(
          "Available Printers",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: kPrimaryTextColor,
          ),
        ),
      ),
      body: Container(
        child: _bodySection(),
      ),
    );
  }

  Widget _bodySection() {
    return Padding(
      padding: EdgeInsets.all(_ac!.rWP(5)),
      child: Container(
        child: _devices.isNotEmpty
            ? ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      await _testPrint(_devices[index]);
                    },
                    leading: const Icon(Icons.print),
                    title: Text("${_devices[index].name}"),
                    subtitle: Text("${_devices[index].address}"),
                  );
                },
              )
            : Center(
                child: Text("$_devicesMsg"),
              ),
      ),
    );
  }

 _testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();

    // TEST PRINT
    // final PosPrintResult res =
    // await printerManager.printTicket(await testTicket(paper));

    // DEMO RECEIPT
    final PosPrintResult res =
        await printerManager.printTicket((await demoReceipt(paper, profile)));
  }

  Future<List<int>> demoReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    // Print image
    // final ByteData data = await rootBundle.load('assets/rabbit_black.jpg');
    // final Uint8List imageBytes = data.buffer.asUint8List();
    // final Image? image = decodeImage(imageBytes);
    // bytes += ticket.image(image);

    bytes += ticket.text('DEMO RECEIPT',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    bytes += ticket.text('889  Watson Lane',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('New Braunfels, TX',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Tel: 830-221-1234',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Web: www.example.com',
        styles: const PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += ticket.hr();
    bytes += ticket.row([
      PosColumn(text: 'Qty', width: 1),
      PosColumn(text: 'Item', width: 7),
      PosColumn(
        text: 'Price',
        width: 2,
        styles: const PosStyles(align: PosAlign.right),
      ),
      PosColumn(
        text: 'Total',
        width: 2,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += ticket.row([
      PosColumn(text: '2', width: 1),
      PosColumn(text: 'ONION RINGS', width: 7),
      PosColumn(
        text: '0.99',
        width: 2,
        styles: const PosStyles(align: PosAlign.right),
      ),
      PosColumn(
        text: '1.98',
        width: 2,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += ticket.row([
      PosColumn(text: '1', width: 1),
      PosColumn(text: 'PIZZA', width: 7),
      PosColumn(
        text: '3.45',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
      PosColumn(
        text: '3.45',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);
    bytes += ticket.row([
      PosColumn(text: '1', width: 1),
      PosColumn(text: 'SPRING ROLLS', width: 7),
      PosColumn(
        text: '2.99',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
      PosColumn(
        text: '2.99',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);
    bytes += ticket.row([
      PosColumn(text: '3', width: 1),
      PosColumn(text: 'CRUNCHY STICKS', width: 7),
      PosColumn(
        text: '0.85',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
      PosColumn(
        text: '2.55',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);
    bytes += ticket.hr();

    bytes += ticket.row([
      PosColumn(
        text: 'TOTAL',
        width: 6,
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
      PosColumn(
        text: '\$10.97',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
    ]);

    bytes += ticket.hr(ch: '=', linesAfter: 1);

    bytes += ticket.row([
      PosColumn(
          text: 'Cash',
          width: 7,
          styles: const PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(
          text: '\$15.00',
          width: 5,
          styles: const PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);
    bytes += ticket.row([
      PosColumn(
          text: 'Change',
          width: 7,
          styles: const PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(
          text: '\$4.03',
          width: 5,
          styles: const PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);

    bytes += ticket.feed(2);
    bytes += ticket.text('Thank you!',
        styles: const PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    bytes += ticket.text(timestamp,
        styles: const PosStyles(align: PosAlign.center), linesAfter: 2);

    // Print QR Code from image
    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 200;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());

    //   bytes += ticket.image(img);
    // } catch (e) {
    //   print(e);
    // }

    // Print QR Code using native function
    // bytes += ticket.qrcode('example.com');

    ticket.feed(2);
    ticket.cut();
    return bytes;
  }

  Future<List<int>> testTicket(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator generator = Generator(paper, profile);
    List<int> bytes = [];

    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    // bytes += generator.text('Special 1: ???? ???? ???? ???? ???? ???? ????',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));
    // bytes += generator.text('Special 2: bl??b??rgr??d',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    bytes +=
        generator.text('Align left', styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    // Print image
    final ByteData data = await rootBundle.load('assets/images/logo.png');
    final Uint8List buf = data.buffer.asUint8List();
    final img.Image image = img.decodeImage(buf)!;
    bytes += generator.image(image);
    // Print image using alternative commands
    // bytes += generator.imageRaster(image);
    // bytes += generator.imageRaster(image, imageFn: PosImageFn.graphics);

    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

    // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
    // bytes += generator.text(
    //   'hello ! ????????? # world @ ??ph??m??re &',
    //   styles: PosStyles(codeTable: PosCodeTable.westEur),
    //   containsChinese: true,
    // );

    bytes += generator.feed(2);

    bytes += generator.cut();
    return bytes;
  }

  @override
  void dispose() {
    super.dispose();
    _stopScanDevices();
  }
}
