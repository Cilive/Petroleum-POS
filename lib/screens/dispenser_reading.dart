import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skysoft/constants/config.dart';
import 'package:skysoft/providers/dispenser_provider.dart';
import 'package:skysoft/utils/enums.dart';
import 'package:skysoft/widgets/custom_button.dart';
import 'package:skysoft/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class DispenserReadingPage extends StatefulWidget {
  const DispenserReadingPage({Key? key}) : super(key: key);

  @override
  _DispenserReadingPageState createState() => _DispenserReadingPageState();
}

class _DispenserReadingPageState extends State<DispenserReadingPage> {
  TextEditingController startReading = TextEditingController();
  TextEditingController endReading = TextEditingController();
  AppConfig? _ac;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      
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
        title: Text(
          "Dispenser Reading",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: _bodySection(),
        ),
      ),
    );
  }

  Widget _bodySection() {
    return Padding(
      padding: EdgeInsets.all(_ac!.rWP(5)),
      child: Container(
        child: Column(
          children: [
            CustomTextfield(
              controller: startReading,
              hint: "Start Reading",
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: endReading,
              hint: "End Reading",
            ),
            const Spacer(),
            Consumer<DispenserProvider>(
              builder: (context, provider, child) {
                if (provider.uploadReadingStatus == Status.LOADING) {
                  return const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            CustomButton(
              title: "Pay",
              onTap: () async {
                Status result = await context
                    .read<DispenserProvider>()
                    .uploadReading(
                        amount: 100.toString(),
                        endReading: endReading.text,
                        startReading: startReading.text);
                if (result == Status.SUCCESS) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Upload Success")),
                  );
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
            )
          ],
        ),
      ),
    );
  }
}
