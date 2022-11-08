import 'package:ada_bread/crediential/login_screen.dart';
import 'package:ada_bread/data_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dataHub/data/daily_production_data.dart';
import 'dataHub/data/data_storage.dart';
import 'dataHub/data/order_data_hub.dart';
import 'dataHub/data/production_data_hub.dart';
import 'expense_screen/daily_expense_pdf_report.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const AdaBread());
  });
}

class AdaBread extends StatefulWidget {
  const AdaBread({Key key}) : super(key: key);

  @override
  State<AdaBread> createState() => _AdaBreadState();
}

class _AdaBreadState extends State<AdaBread> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => DataStorage(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => DataProvider()
            ..loadSoldList()
            ..loadLoggedUser()
            ..loadProductionList()
            ..loadExpenseList(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FileHandlerForExpense(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => OrderDataHub()..loadOrderList(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => DailyProductionData(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              ProductionModelData()..loadContratList(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
      ),
    );
  }
}
