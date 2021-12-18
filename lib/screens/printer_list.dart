import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skysoft/constants/config.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';

class PrinterList extends StatefulWidget {
  const PrinterList({Key? key}) : super(key: key);

  @override
  _PrinterListState createState() => _PrinterListState();
}

class _PrinterListState extends State<PrinterList> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  AppConfig? _ac;

  @override
  void initState() {
    super.initState();
    printerManager.scanResults.listen((devices) async {
      setState(() {
        _devices = devices;
      });
    });
  }

  void _startScanDevices() {
    setState(() {
      _devices = [];
    });
    printerManager.startScan(Duration(seconds: 4));
  }

  void _stopScanDevices() {
    printerManager.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _startScanDevices();
            },
            icon: Icon(Icons.refresh),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          "Available Printers",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.black87,
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
        child: ListView.builder(
          itemCount: _devices.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.print),
              title: Text("${_devices[index].name}"),
              subtitle: Text("${_devices[index].address}"),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _stopScanDevices();
  }
}
