import 'package:ada_bread/expense_screen/expense_screen.dart';
import 'package:ada_bread/order_screen/order_screen.dart';
import 'package:ada_bread/production_screen/production_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dataHub/data/data_storage.dart';
import 'bottom_nav_item.dart';
import 'main_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final List screens = [
    const MainScreen(),
    const ProductionPage(),
    OrderScreen(),
    const ExpenseScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<DataStorage>(context).index;

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: MyCustomBottomNavigationBar(),
    );
  }
}
