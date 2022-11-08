import 'package:ada_bread/dataHub/data/daily_production_data.dart';
import 'package:ada_bread/data_provider.dart';
import 'package:ada_bread/drawer/custom_drawer.dart';
import 'package:ada_bread/main_screen/product_delivered_to_shop_input.dart';
import 'package:ada_bread/main_screen/seller_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../dataHub/data/data_storage.dart';
import '../drop_down_menu_button.dart';
import '../profit_analysis/profit_analysis_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedDayOfMonth = DateTime.now().day;
  bool isTapped = true;
  int columnCount = 2;
  double totalSold = 0;
  double totalExpected = 0;

  bool isNegative = false;
  bool isExpanded = false;

  @override
  void initState() {
    totalSold;
    totalExpected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    final daySelected = Provider.of<DataStorage>(context).daysOfMonth;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADA BREAD',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('DailyShopSell')
              .snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
              );
            }
            final expense =
                Provider.of<DataProvider>(context, listen: false).expenseList;

            final result = expense
                .where((element) =>
                    DateTime.parse(element['itemDate']).year ==
                    DateTime.now().year)
                .toList();

            var todayMonthFilteredList = result
                .where((element) =>
                    DateTime.parse(element['itemDate']).month ==
                    DateTime.now().month)
                .toList();
            var dailyExpense = todayMonthFilteredList
                .where((element) =>
                    DateTime.parse(element['itemDate']).day ==
                    selectedDayOfMonth)
                .toList();
            var totalExpenses = result.map((e) => e['itemPrice']).toList();
            var totalExpensesQuantity =
                result.map((e) => e['itemQuantity']).toList();
            var totExpenseSum = 0.0;
            for (int xx = 0; xx < totalExpenses.length; xx++) {
              totExpenseSum += (double.parse(totalExpenses[xx]) *
                  double.parse(totalExpensesQuantity[xx]));
            }
            var totalMonthlyExpenses =
                dailyExpense.map((e) => e['itemPrice']).toList();
            var totalMonthlyExpensesQuantity =
                dailyExpense.map((e) => e['itemQuantity']).toList();
            final dailyExpensesAdmin =
                Provider.of<DataProvider>(context).dailyExpense;
            var totMonthlyExpenseSum = 0.0;
            for (int xx = 0; xx < totalMonthlyExpenses.length; xx++) {
              totMonthlyExpenseSum += (double.parse(totalMonthlyExpenses[xx]) *
                  double.parse(totalMonthlyExpensesQuantity[xx]));
            }
            final productionData = snap.data.docs;
            final loggedInEmployee =
                Provider.of<DataProvider>(context).loggedUserList;
            var shopSold = loggedInEmployee
                .where((element) =>
                    DateTime.parse(element['loggedDate']).day ==
                    selectedDayOfMonth)
                .toList();

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              dropdownColor: Colors.grey[850],
                              iconEnabledColor: Colors.white,
                              menuMaxHeight: 300,
                              value: selectedDayOfMonth,
                              items: daySelected
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(
                                        e['mon'],
                                        style: kkDropDown,
                                      ),
                                      value: e['day'],
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDayOfMonth = value as int;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Daily Expense: $totMonthlyExpenseSum',
                                  style: dailyIncomeStyle,
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Daily Income: $totalSold',
                                  style: dailyIncomeStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    color: const Color.fromRGBO(3, 83, 151, 1),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: AnimationLimiter(
                    child: shopSold.isEmpty
                        ? Center(
                            child: Image.asset(
                              'images/closed-sign.png',
                              width: 150,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(_w / 30),
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: shopSold.length,
                            itemBuilder: (BuildContext context, int index) {
                              final itemTypeForAdmin = productionData
                                  .where(
                                      (element) => element['isWhat'] == 'given')
                                  .toList();
                              final whoIsForAdmin = itemTypeForAdmin
                                  .where((element) =>
                                      element['seller'] ==
                                      shopSold[index]['userEmail'])
                                  .toList();
                              final employeeSoldYearFilterForAdmin =
                                  whoIsForAdmin
                                      .where((element) =>
                                          DateTime.parse(element['givenDate'])
                                              .year ==
                                          DateTime.now().year)
                                      .toList();

                              var employeeSoldMonthFilterForAdmin =
                                  employeeSoldYearFilterForAdmin
                                      .where((element) =>
                                          DateTime.parse(element['givenDate'])
                                              .month ==
                                          DateTime.now().month)
                                      .toList();
                              var employeeSoldDayFilterForAdmin =
                                  employeeSoldMonthFilterForAdmin
                                      .where((element) =>
                                          DateTime.parse(element['givenDate'])
                                              .day ==
                                          selectedDayOfMonth)
                                      .toList();

                              /*
                    *
                    *
                    *
                    *
                    * */

                              /*


                      BALE 5 ForAdmin
                    *
                    *
                    *
                    * */
                              var totalEmployeeSoldBale_5ForAdmin =
                                  employeeSoldDayFilterForAdmin
                                      .map((e) => e['bale_5'])
                                      .toList();

                              var totalEmployeeSoldSumBale_5ForAdmin = 0;
                              for (int xx = 0;
                                  xx < totalEmployeeSoldBale_5ForAdmin.length;
                                  xx++) {
                                totalEmployeeSoldSumBale_5ForAdmin += int.parse(
                                    totalEmployeeSoldBale_5ForAdmin[xx]);
                              }

                              /*


                      BALE 10 ForAdmin
                    *
                    *
                    *
                    * */
                              var totalEmployeeSoldBale_10ForAdmin =
                                  employeeSoldDayFilterForAdmin
                                      .map((e) => e['bale_10'])
                                      .toList();

                              var totalEmployeeSoldSumBale_10ForAdmin = 0;
                              for (int xx = 0;
                                  xx < totalEmployeeSoldBale_10ForAdmin.length;
                                  xx++) {
                                totalEmployeeSoldSumBale_10ForAdmin +=
                                    int.parse(
                                        totalEmployeeSoldBale_10ForAdmin[xx]);
                              }
                              /*


                       SLICE ForAdmin
                    *
                    *
                    *
                    * */
                              var totalEmployeeSoldSliceForAdmin =
                                  employeeSoldDayFilterForAdmin
                                      .map((e) => e['slice'])
                                      .toList();

                              var totalEmployeeSoldSumSliceForAdmin = 0;
                              for (int xx = 0;
                                  xx < totalEmployeeSoldSliceForAdmin.length;
                                  xx++) {
                                totalEmployeeSoldSumSliceForAdmin += int.parse(
                                    totalEmployeeSoldSliceForAdmin[xx]);
                              }
                              /*


                     BOMBOLINO ForAdmin
                    *
                    *
                    *
                    * */
                              var totalEmployeeSoldBombolinoForAdmin =
                                  employeeSoldDayFilterForAdmin
                                      .map((e) => e['bombolino'])
                                      .toList();

                              var totalEmployeeSoldSumBombolinoForAdmin = 0;
                              for (int xx = 0;
                                  xx <
                                      totalEmployeeSoldBombolinoForAdmin.length;
                                  xx++) {
                                totalEmployeeSoldSumBombolinoForAdmin +=
                                    int.parse(
                                        totalEmployeeSoldBombolinoForAdmin[xx]);
                              }

                              /*
                    *
                    * TOTAL EXPECTED INCOME BALE_5
                    *
                    *
                    * */
                              final double totalBale_5ForAdmin =
                                  totalEmployeeSoldSumBale_5ForAdmin *
                                      (employeeSoldDayFilterForAdmin.isEmpty
                                          ? 0.0
                                          : double.parse(
                                              employeeSoldDayFilterForAdmin
                                                  .last['bale_5_Sp']));
                              /*
                    *
                    * TOTAL EXPECTED INCOME BALE_10
                    *
                    *
                    * */
                              final double totalBale_10ForAdmin =
                                  totalEmployeeSoldSumBale_10ForAdmin *
                                      (employeeSoldDayFilterForAdmin.isEmpty
                                          ? 0.0
                                          : double.parse(
                                              employeeSoldDayFilterForAdmin
                                                  .last['bale_10_Sp']));
                              /*
                    *
                    * TOTAL EXPECTED INCOME SLICE
                    *
                    *
                    * */
                              final double totalSliceForAdmin =
                                  totalEmployeeSoldSumSliceForAdmin *
                                      (employeeSoldDayFilterForAdmin.isEmpty
                                          ? 0.0
                                          : double.parse(
                                              employeeSoldDayFilterForAdmin
                                                  .last['slice_Sp']));
                              /*
                    *
                    * TOTAL EXPECTED INCOME BOMBOLINO
                    *
                    *
                    * */
                              final double totalBombolinoForAdmin =
                                  totalEmployeeSoldSumBombolinoForAdmin *
                                      (employeeSoldDayFilterForAdmin.isEmpty
                                          ? 0.0
                                          : double.parse(
                                              employeeSoldDayFilterForAdmin
                                                  .last['bombolino_Sp']));

                              /*
                    *
                    * SOLD ITEM
                    *
                    *
                    * */
                              final itemType = productionData
                                  .where(
                                      (element) => element['isWhat'] == 'sold')
                                  .toList();
                              final whoIs = itemType
                                  .where((element) =>
                                      element['employeeEmail'] ==
                                      shopSold[index]['userEmail'])
                                  .toList();
                              final employeeSoldYearFilter = whoIs
                                  .where((element) =>
                                      DateTime.parse(element['date']).year ==
                                      DateTime.now().year)
                                  .toList();

                              var employeeSoldMonthFilter =
                                  employeeSoldYearFilter
                                      .where((element) =>
                                          DateTime.parse(element['date'])
                                              .month ==
                                          DateTime.now().month)
                                      .toList();
                              var employeeSoldDayFilter =
                                  employeeSoldMonthFilter
                                      .where((element) =>
                                          DateTime.parse(element['date']).day ==
                                          selectedDayOfMonth)
                                      .toList();
                              /*


                      BALE 5
                    *
                    *
                    *
                    * */
                              var totalEmployeeSoldBale_5 =
                                  employeeSoldDayFilter
                                      .map((e) => e['bale_5'])
                                      .toList();

                              var totalEmployeeSoldSumBale_5 = 0;
                              for (int xx = 0;
                                  xx < totalEmployeeSoldBale_5.length;
                                  xx++) {
                                totalEmployeeSoldSumBale_5 +=
                                    int.parse(totalEmployeeSoldBale_5[xx]);
                              }

                              /*


                      BALE 10
                    *
                    *
                    *
                    * */
                              var totalEmployeeSoldBale_10 =
                                  employeeSoldDayFilter
                                      .map((e) => e['bale_10'])
                                      .toList();

                              var totalEmployeeSoldSumBale_10 = 0;
                              for (int xx = 0;
                                  xx < totalEmployeeSoldBale_10.length;
                                  xx++) {
                                totalEmployeeSoldSumBale_10 +=
                                    int.parse(totalEmployeeSoldBale_10[xx]);
                              }
                              /*


                       SLICE
                    *
                    *
                    *
                    * */
                              var totalEmployeeSoldSlice = employeeSoldDayFilter
                                  .map((e) => e['slice'])
                                  .toList();

                              var totalEmployeeSoldSumSlice = 0;
                              for (int xx = 0;
                                  xx < totalEmployeeSoldSlice.length;
                                  xx++) {
                                totalEmployeeSoldSumSlice +=
                                    int.parse(totalEmployeeSoldSlice[xx]);
                              }
                              /*


                     BOMBOLINO
                    *
                    *
                    *
                    * */
                              var totalEmployeeSoldBombolino =
                                  employeeSoldDayFilter
                                      .map((e) => e['bombolino'])
                                      .toList();

                              var totalEmployeeSoldSumBombolino = 0;
                              for (int xx = 0;
                                  xx < totalEmployeeSoldBombolino.length;
                                  xx++) {
                                totalEmployeeSoldSumBombolino +=
                                    int.parse(totalEmployeeSoldBombolino[xx]);
                              }
                              /*
                    *
                    * TOTAL INCOME BALE_5
                    *
                    *
                    * */
                              final double totalBale_5 =
                                  totalEmployeeSoldSumBale_5 *
                                      (employeeSoldDayFilter.isEmpty
                                          ? 0.0
                                          : double.parse(employeeSoldDayFilter
                                              .last['bale_5_Sp']));
                              /*
                    *
                    * TOTAL INCOME BALE_10
                    *
                    *
                    * */
                              final double totalBale_10 =
                                  totalEmployeeSoldSumBale_10 *
                                      (employeeSoldDayFilter.isEmpty
                                          ? 0.0
                                          : double.parse(employeeSoldDayFilter
                                              .last['bale_10_Sp']));
                              /*
                    *
                    * TOTAL INCOME SLICE
                    *
                    *
                    * */
                              final double totalSlice =
                                  totalEmployeeSoldSumSlice *
                                      (employeeSoldDayFilter.isEmpty
                                          ? 0.0
                                          : double.parse(employeeSoldDayFilter
                                              .last['slice_Sp']));
                              /*
                    *
                    * TOTAL INCOME BOMBOLINO
                    *
                    *
                    * */
                              final double totalBombolino =
                                  totalEmployeeSoldSumBombolino *
                                      (employeeSoldDayFilter.isEmpty
                                          ? 0.0
                                          : double.parse(employeeSoldDayFilter
                                              .last['bombolino_Sp']));

                              /*
                    *
                    *
                    *
                    * Sum of ALL SOLD ITEMS
                    *
                    *
                    *
                    *
                    * */
                              final listOfPriceForAdmin = [
                                {
                                  'image': 'images/bale_5.png',
                                  'sold': '$totalEmployeeSoldSumBale_5',
                                  'given':
                                      '$totalEmployeeSoldSumBale_5ForAdmin',
                                },
                                {
                                  'image': 'images/bale_10.png',
                                  'sold': '$totalEmployeeSoldSumBale_10',
                                  'given':
                                      '$totalEmployeeSoldSumBale_10ForAdmin',
                                },
                                {
                                  'image': 'images/slice.png',
                                  'sold': '$totalEmployeeSoldSumSlice',
                                  'given': '$totalEmployeeSoldSumSliceForAdmin',
                                },
                                {
                                  'image': 'images/donut.png',
                                  'sold': '$totalEmployeeSoldSumBombolino',
                                  'given':
                                      '$totalEmployeeSoldSumBombolinoForAdmin',
                                }
                              ];
                              Provider.of<DailyProductionData>(context)
                                  .totalSoldData(
                                      totalEmployeeSoldSumBale_5.toString(),
                                      totalEmployeeSoldSumBale_10.toString(),
                                      totalEmployeeSoldSumSlice.toString(),
                                      totalEmployeeSoldSumBombolino.toString());
                              totalSold = (totalBale_5 +
                                  totalBale_10 +
                                  totalSlice +
                                  totalBombolino);
                              double expectedIncome = (totalBale_5ForAdmin +
                                  totalBale_10ForAdmin +
                                  totalSliceForAdmin +
                                  totalBombolinoForAdmin);

                              int sumOfSoldItem = (totalEmployeeSoldSumBale_5 +
                                  totalEmployeeSoldSumBale_10 +
                                  totalEmployeeSoldSumSlice +
                                  totalEmployeeSoldSumBombolino);
                              int sumOfGivenItems =
                                  (totalEmployeeSoldSumBale_5ForAdmin +
                                      totalEmployeeSoldSumBale_10ForAdmin +
                                      totalEmployeeSoldSumSliceForAdmin +
                                      totalEmployeeSoldSumBombolinoForAdmin);
                              Provider.of<DataProvider>(context).binders(
                                  sumOfSoldItem.toString(),
                                  sumOfGivenItems.toString());
                              Provider.of<DataProvider>(context).totalIncome(
                                  totalSold.toString(),
                                  expectedIncome.toString());
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  horizontalOffset: -300,
                                  verticalOffset: -850,
                                  child: InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onDoubleTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) =>
                                              ProductDeliveredToShopInput(
                                            loggedUser: shopSold[index]
                                                ['userEmail'],
                                          ),
                                        ),
                                      );
                                    },
                                    onTap: () {
                                      setState(() {
                                        isTapped = !isTapped;
                                      });
                                    },
                                    onHighlightChanged: (value) {
                                      setState(() {
                                        isExpanded = value;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: AnimatedContainer(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8),
                                            margin: const EdgeInsets.only(
                                                left: 8.0, right: 8, top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color.fromRGBO(
                                                      40, 53, 147, 1),
                                                  const Color.fromRGBO(
                                                          40, 53, 147, 1)
                                                      .withOpacity(0.9)
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  blurRadius: 4,
                                                  offset: const Offset(4,
                                                      8), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            duration:
                                                const Duration(seconds: 1),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            height: isTapped
                                                ? isExpanded
                                                    ? 160
                                                    : 160
                                                : isExpanded
                                                    ? 200
                                                    : 400,
                                            width: isExpanded ? 345 : 350,
                                            child: isTapped
                                                ? Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 25,
                                                                  bottom: 25,
                                                                  left: 5),
                                                          child: Image.asset(
                                                              'images/employee.png'),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10,
                                                                  left: 5),
                                                          // decoration: BoxDecoration(
                                                          //   border: Border.all(
                                                          //     color: Colors.blue,
                                                          //     width: 2,
                                                          //   ),
                                                          // ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                shopSold[index][
                                                                    'username'],
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                        'Expected : ',
                                                                        style:
                                                                            kkSummaryIncomes,
                                                                      ),
                                                                      Text(
                                                                        expectedIncome
                                                                            .toStringAsFixed(2),
                                                                        style:
                                                                            kkSummaryIncomes,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Sold Price',
                                                                          style:
                                                                              kkSummaryExpense,
                                                                        ),
                                                                        Text(
                                                                          totalSold
                                                                              .toStringAsFixed(2),
                                                                          style:
                                                                              kkSummaryExpense,
                                                                        ),
                                                                      ]),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: SizedBox(
                                                                  height: 50,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: <
                                                                        Widget>[
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                        width:
                                                                            170,
                                                                        child:
                                                                            FAProgressBar(
                                                                          size:
                                                                              20,
                                                                          backgroundColor:
                                                                              Colors.grey,
                                                                          progressColor:
                                                                              Colors.green,
                                                                          currentValue: totalSold == 0
                                                                              ? 0
                                                                              : (totalSold / expectedIncome) * 100,
                                                                          displayText:
                                                                              '%',
                                                                          displayTextStyle:
                                                                              const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        isTapped
                                                            ? Icons
                                                                .keyboard_arrow_down
                                                            : Icons
                                                                .keyboard_arrow_up,
                                                        color: Colors.black,
                                                        size: 27,
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Image.asset(
                                                                'images/employee.png'),
                                                          ),
                                                          Expanded(
                                                            flex: 4,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      left: 5),
                                                              // decoration: BoxDecoration(
                                                              //   border: Border.all(
                                                              //     color: Colors.blue,
                                                              //     width: 2,
                                                              //   ),
                                                              // ),
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        const Text(
                                                                          'Expected :',
                                                                          style:
                                                                              kkSummaryIncome,
                                                                        ),
                                                                        Text(
                                                                          expectedIncome
                                                                              .toStringAsFixed(2),
                                                                          style:
                                                                              kkSummaryIncome,
                                                                        ),
                                                                      ],
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        const Text(
                                                                          'Sold Price',
                                                                          style:
                                                                              kkSummaryExpense,
                                                                        ),
                                                                        Text(
                                                                            totalSold.toStringAsFixed(
                                                                                2),
                                                                            style:
                                                                                kkSummaryExpense),
                                                                      ],
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Icon(
                                                            isTapped
                                                                ? Icons
                                                                    .keyboard_arrow_down
                                                                : Icons
                                                                    .keyboard_arrow_up,
                                                            color: Colors.black,
                                                            size: 27,
                                                          ),
                                                        ],
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              AnimatedContainer(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    right: 8),
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    right: 8,
                                                                    top: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  const Color
                                                                          .fromRGBO(
                                                                      40,
                                                                      53,
                                                                      147,
                                                                      1),
                                                                  const Color.fromRGBO(
                                                                          40,
                                                                          53,
                                                                          147,
                                                                          1)
                                                                      .withOpacity(
                                                                          0.9)
                                                                ],
                                                              ),
                                                            ),
                                                            duration:
                                                                const Duration(
                                                                    seconds: 1),
                                                            curve: Curves
                                                                .fastLinearToSlowEaseIn,
                                                            height: 390,
                                                            width: 350,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      DateFormat
                                                                              .E()
                                                                          .format(
                                                                        DateTime
                                                                            .now(),
                                                                      ),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        fontSize:
                                                                            25,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                        'Tot Income: $totalSold',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w900,
                                                                          fontSize:
                                                                              20,
                                                                        )),
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child:
                                                                      AnimationLimiter(
                                                                    child: GridView
                                                                        .count(
                                                                      physics: const BouncingScrollPhysics(
                                                                          parent:
                                                                              AlwaysScrollableScrollPhysics()),
                                                                      padding: EdgeInsets
                                                                          .all(_w /
                                                                              60),
                                                                      crossAxisCount:
                                                                          columnCount,
                                                                      children: listOfPriceForAdmin
                                                                          .map(
                                                                            (e) =>
                                                                                AnimationConfiguration.staggeredGrid(
                                                                              position: index,
                                                                              duration: const Duration(milliseconds: 500),
                                                                              columnCount: columnCount,
                                                                              child: ScaleAnimation(
                                                                                duration: const Duration(milliseconds: 900),
                                                                                curve: Curves.fastLinearToSlowEaseIn,
                                                                                child: FadeInAnimation(
                                                                                  child: Container(
                                                                                    margin: EdgeInsets.only(bottom: _w / 100, left: _w / 60, right: _w / 60),
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                                    ),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Image.asset(
                                                                                          e['image'],
                                                                                          width: 40,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              const Text(
                                                                                                'Given',
                                                                                                style: TextStyle(fontWeight: FontWeight.w900),
                                                                                              ),
                                                                                              Text(e['given']),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              const Text(
                                                                                                'Sold',
                                                                                                style: TextStyle(fontWeight: FontWeight.w900),
                                                                                              ),
                                                                                              Text(e['sold']),
                                                                                            ],
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                          .toList(),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: Builder(
        builder: (context) => DropDownMenuButton(
            primaryColor: Colors.red,
            button_1: () {},
            button_2: () {},
            button_3: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const SellerDetail()),
              );
            },
            button_4: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => ProfitAnalaysisScreen()),
              );
            }),
      ),
      drawer: CustomDrawer(),
    );
  }
}
