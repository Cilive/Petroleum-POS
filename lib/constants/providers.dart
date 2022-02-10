import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skysoft/providers/auth_provider.dart';
import 'package:skysoft/providers/dispenser_provider.dart';
import 'package:skysoft/providers/general_provider.dart';
import 'package:skysoft/providers/invoice_provider.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => InvoiceProvider()),
  ChangeNotifierProvider(create: (_) => DispenserProvider()),
  ChangeNotifierProvider(create: (_) => GeneralProvider()),
];
