import 'package:ada_bread/dataHub/data/expenses_data.dart';
import 'package:ada_bread/data_provider.dart';
import 'package:ada_bread/main_screen/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dataHub/data/daily_production_data.dart';
import 'dataHub/data/data_storage.dart';
import 'dataHub/data/order_data_hub.dart';
import 'dataHub/data/production_data_hub.dart';
import 'expense_screen/daily_expense_pdf_report.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AdaBread());
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
          create: (BuildContext context) => DataProvider()..loadSoldList(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FileHandlerForExpense(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ExpensesData()..loadExpenseList(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => OrderDataHub()..loadOrderList(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              DailyProductionData()..loadProductionList(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              ProductionModelData()..loadContractList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
