import 'package:ada_bread/dataHub/data/daily_production_data.dart';
import 'package:ada_bread/data_provider.dart';
import 'package:ada_bread/main_screen/product_delivered_to_shop_input.dart';
import 'package:ada_bread/main_screen/seller_detail.dart';
import 'package:ada_bread/profit_analysis/profit_analysis_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../dataHub/data/data_storage.dart';
import '../dataHub/data/expenses_data.dart';
import '../drop_down_menu_button.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedDayOfMonth = DateTime.now().day;
  bool isTapped = true;
  int columnCount = 2;
  double totalSumation = 0.00;
  bool isNegative = false;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    List<String> imageOfBread = [
      'images/bale_5.png',
      'images/bale_10.png',
      'images/slice.png',
      'images/donut.png'
    ];
    double _w = MediaQuery.of(context).size.width;

    final daySelected = Provider.of<DataStorage>(context).daysOfMonth;
    final yearFilter = Provider.of<ExpensesData>(context).expenseList;
    final result = yearFilter
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();

    var todayMonthFilteredList = result
        .where((element) =>
            DateTime.parse(element.itemDate).month == DateTime.now().month)
        .toList();
    var dailyExpenses = todayMonthFilteredList
        .where((element) =>
            DateTime.parse(element.itemDate).day == selectedDayOfMonth)
        .toList();
    var totalDailyExpense = dailyExpenses.map((e) => e.itemPrice).toList();
    var totDailySum = 0.0;
    for (int xx = 0; xx < totalDailyExpense.length; xx++) {
      totDailySum += double.parse(totalDailyExpense[xx]);
    }
    final summaryContract =
        Provider.of<DailyProductionData>(context).productionList;
    summaryContract.sort();
    final filterByYearProduction = summaryContract
        .where((element) =>
            DateTime.parse(element.producedDate).year == DateTime.now().year)
        .toList();
    final filterByMonthProduction = filterByYearProduction
        .where((element) =>
            DateTime.parse(element.producedDate).month == DateTime.now().month)
        .toList();
    final filterByDayProduction = filterByMonthProduction
        .where((element) =>
            DateTime.parse(element.producedDate).day == DateTime.now().day)
        .toList();
    double totPriceProductionOfBale_5 = filterByDayProduction.isEmpty
        ? 0
        : (double.parse(filterByDayProduction.first.bale_5) *
            double.parse(filterByDayProduction.first.bale_5_Sp));
    double totPriceProductionOfBale_10 = filterByDayProduction.isEmpty
        ? 0
        : (double.parse(filterByDayProduction.first.bale_10) *
            double.parse(filterByDayProduction.first.bale_10_Sp));
    double totPriceProductionOfSlice = filterByDayProduction.isEmpty
        ? 0
        : (double.parse(filterByDayProduction.first.slice) *
            double.parse(filterByDayProduction.first.slice_Sp));
    double totPriceProductionOfBombolino = filterByDayProduction.isEmpty
        ? 0
        : (double.parse(filterByDayProduction.first.bombolino) *
            double.parse(filterByDayProduction.first.bombolino_Sp));
    final double expectedIncomSum = totPriceProductionOfBale_5 +
        totPriceProductionOfBale_10 +
        totPriceProductionOfSlice +
        totPriceProductionOfBombolino;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADA\'S BREAD'),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        actions: [
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
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
                            'Daily Expense: $totDailySum',
                            style: dailyIncomeStyle,
                          ),
                          const Text(
                            'Daily Income: 120',
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
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('LoggedUser')
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
                final productionData = snap.data.docs;
                final shopSold =
                    Provider.of<DataProvider>(context).databaseDataForShop;

                final resultShopSold = shopSold
                    .where((element) =>
                        DateTime.parse(element['producedDate']).year ==
                        DateTime.now().year)
                    .toList();

                var todayMonthFilteredList = resultShopSold
                    .where((element) =>
                        DateTime.parse(element['producedDate']).month ==
                        DateTime.now().month)
                    .toList();
                var dailySoldItems = todayMonthFilteredList
                    .where((element) =>
                        DateTime.parse(element['producedDate']).day ==
                        selectedDayOfMonth)
                    .toList();
                var totalDailySoldItemsBale_5 =
                    dailySoldItems.map((e) => e['bale_5']).toList();

                var totDailySoldSumBale_5 = 0;
                for (int xx = 0; xx < totalDailySoldItemsBale_5.length; xx++) {
                  totDailySoldSumBale_5 +=
                      int.parse(totalDailySoldItemsBale_5[xx]);
                }
                var totalDailySoldItemsBale_10 =
                    dailySoldItems.map((e) => e['bale_10']).toList();

                var totDailySoldSumBale_10 = 0;
                for (int xx = 0; xx < totalDailySoldItemsBale_10.length; xx++) {
                  totDailySoldSumBale_10 +=
                      int.parse(totalDailySoldItemsBale_10[xx]);
                }
                var totalDailySoldItemsSlice =
                    dailySoldItems.map((e) => e['slice']).toList();

                var totDailySoldSumSlice = 0;
                for (int xx = 0; xx < totalDailySoldItemsSlice.length; xx++) {
                  totDailySoldSumSlice +=
                      int.parse(totalDailySoldItemsSlice[xx]);
                }
                var totalDailySoldItemsBombolino =
                    dailySoldItems.map((e) => e['bombolino']).toList();

                var totDailySoldSumBombolino = 0;
                for (int xx = 0;
                    xx < totalDailySoldItemsBombolino.length;
                    xx++) {
                  totDailySoldSumBombolino +=
                      int.parse(totalDailySoldItemsBombolino[xx]);
                }
                final double totalBale_5 = totDailySoldSumBale_5 *
                    (dailySoldItems.isEmpty
                        ? 0.0
                        : double.parse(dailySoldItems.last['bale_5_Sp']));
                final double totalBale_10 = totDailySoldSumBale_10 *
                    (dailySoldItems.isEmpty
                        ? 0.0
                        : double.parse(dailySoldItems.last['bale_10_Sp']));
                final double totalSlice = totDailySoldSumSlice *
                    (dailySoldItems.isEmpty
                        ? 0.0
                        : double.parse(dailySoldItems.last['slice_Sp']));
                final double totalBombolino = totDailySoldSumBombolino *
                    (dailySoldItems.isEmpty
                        ? 0.0
                        : double.parse(dailySoldItems.last['bombolino_Sp']));
                double totalSumOfShop =
                    totalBale_5 + totalBale_10 + totalSlice + totalBombolino;
                final listOfPrice = [
                  {
                    'image': 'images/bale_5.png',
                    'price': '$totDailySoldSumBale_5',
                  },
                  {
                    'image': 'images/bale_10.png',
                    'price': '$totDailySoldSumBale_10',
                  },
                  {
                    'image': 'images/slice.png',
                    'price': '$totDailySoldSumSlice',
                  },
                  {
                    'image': 'images/donut.png',
                    'price': '$totDailySoldSumBombolino',
                  }
                ];

                return dailySoldItems.isEmpty
                    ? Center(
                        child: Image.asset(
                          'images/cloud.png',
                          width: 150,
                          fit: BoxFit.contain,
                        ),
                      )
                    : AnimationLimiter(
                        child: ListView.builder(
                          padding: EdgeInsets.all(_w / 30),
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: productionData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                horizontalOffset: -300,
                                verticalOffset: -850,
                                child: loggedUser(
                                    productionData[index]['userEmail'],
                                    listOfPrice,
                                    productionData,
                                    index,
                                    expectedIncomSum,
                                    _w,
                                    imageOfBread,
                                    shopSold,
                                    totalSumOfShop),
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ],
      ),
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
    );
  }

  InkWell loggedUser(
      String loggedIn,
      List<Map<String, String>> priceList,
      List<QueryDocumentSnapshot<Object>> productionData,
      int index,
      double expectedIncomSum,
      double _w,
      List<String> imageOfBread,
      List<Map<String, dynamic>> shopSold,
      double sum) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onDoubleTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDeliveredToShopInput(
              loggedUser: loggedIn,
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
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              margin: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(40, 53, 147, 1),
                    const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(4, 8), // changes position of shadow
                  ),
                ],
              ),
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              height: isTapped
                  ? isExpanded
                      ? 125
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
                            padding: const EdgeInsets.only(
                                top: 25, bottom: 25, left: 5),
                            child: Image.asset('images/employee.png'),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.blue,
                            //     width: 2,
                            //   ),
                            // ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  productionData[index]['username'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Expected Income: ',
                                          style: kkSummaryIncomes,
                                        ),
                                        Text(
                                          '$expectedIncomSum',
                                          style: kkSummaryIncomes,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Sold Price',
                                            style: kkSummaryExpense,
                                          ),
                                          Text(
                                            sum.toString(),
                                            style: kkSummaryExpense,
                                          ),
                                        ]),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20,
                                          width: 170,
                                          child: FAProgressBar(
                                            size: 20,
                                            backgroundColor: Colors.grey,
                                            progressColor: Colors.green,
                                            currentValue: sum == 0
                                                ? 0
                                                : (sum / 20000) * 100,
                                            displayText: '%',
                                            displayTextStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
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
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
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
                              child: Image.asset('images/employee.png'),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 5),
                                // decoration: BoxDecoration(
                                //   border: Border.all(
                                //     color: Colors.blue,
                                //     width: 2,
                                //   ),
                                // ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const [
                                          Text(
                                            'Expected Income:',
                                            style: kkSummaryIncome,
                                          ),
                                          Text(
                                            '200',
                                            style: kkSummaryIncome,
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Sold Price',
                                            style: kkSummaryExpense,
                                          ),
                                          Text(sum.toStringAsFixed(2),
                                              style: kkSummaryExpense),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              isTapped
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              color: Colors.black,
                              size: 27,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              margin: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    const Color.fromRGBO(40, 53, 147, 1),
                                    const Color.fromRGBO(40, 53, 147, 1)
                                        .withOpacity(0.9)
                                  ],
                                ),
                              ),
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: 380,
                              width: 350,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat.E().format(
                                          DateTime.now(),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text('Tot Income: $sum',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                          )),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: AnimationLimiter(
                                      child: GridView.count(
                                        physics: const BouncingScrollPhysics(
                                            parent:
                                                AlwaysScrollableScrollPhysics()),
                                        padding: EdgeInsets.all(_w / 60),
                                        crossAxisCount: columnCount,
                                        children: priceList
                                            .map(
                                              (e) => AnimationConfiguration
                                                  .staggeredGrid(
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                columnCount: columnCount,
                                                child: ScaleAnimation(
                                                  duration: const Duration(
                                                      milliseconds: 900),
                                                  curve: Curves
                                                      .fastLinearToSlowEaseIn,
                                                  child: FadeInAnimation(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: _w / 30,
                                                          left: _w / 60,
                                                          right: _w / 60),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Image.asset(
                                                            e['image'],
                                                            width: 50,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: const [
                                                                Text(
                                                                  'Given',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                                Text('300'),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Sold',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                                Text(
                                                                    e['price']),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
