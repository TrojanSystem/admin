import 'package:ada_bread/main_screen/seller_detail.dart';
import 'package:ada_bread/profit_analysis/summary_expense_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class ProfitAnalaysis extends StatefulWidget {
  final int index;
  final int currentYear;
  final List yearlyExpense;
  final List yearlyContrat;
  final List yearlyOrder;
  final List yearlySold;

  ProfitAnalaysis(
      {this.index,
      this.yearlySold,
      this.currentYear,
      this.yearlyContrat,
      this.yearlyExpense,
      this.yearlyOrder});

  @override
  State<ProfitAnalaysis> createState() => _ProfitAnalaysisState();
}

class _ProfitAnalaysisState extends State<ProfitAnalaysis> {
  bool isTapped = true;
  double totalSumation = 0.00;
  bool isNegative = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final monthOfYear = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    var monthlyExpense = widget.yearlyExpense
        .where((element) =>
            DateFormat.MMM()
                .format(DateTime.parse(element['itemDate']))
                .toString() ==
            monthOfYear[widget.index])
        .toList();
    var totalMonthlyExpenses =
        monthlyExpense.map((e) => e['itemPrice']).toList();
    var totalMonthlyExpensesQuantity =
        monthlyExpense.map((e) => e['itemQuantity']).toList();
    var totMonthlyExpenseSum = 0.0;
    for (int xx = 0; xx < totalMonthlyExpenses.length; xx++) {
      totMonthlyExpenseSum += (double.parse(totalMonthlyExpenses[xx]) *
          double.parse(totalMonthlyExpensesQuantity[xx]));
    }
    /*
   *
   *
   * CONTRAT MONTHLY SUM
   *
   *
   *
   *
   * */
    var monthlyContratIncome = widget.yearlyContrat
        .where((element) =>
            DateFormat.MMM()
                .format(DateTime.parse(element['date']))
                .toString() ==
            monthOfYear[widget.index])
        .toList();
    var totalMonthlyContratPrice =
        monthlyContratIncome.map((e) => e['price']).toList();
    var totalMonthlyContratQuantity =
        monthlyContratIncome.map((e) => e['quantity']).toList();
    var totMonthlyContratSum = 0.0;
    for (int xx = 0; xx < totalMonthlyContratPrice.length; xx++) {
      totMonthlyContratSum += (double.parse(totalMonthlyContratPrice[xx]) *
          double.parse(totalMonthlyContratQuantity[xx]));
    }
    /*
    *
    * ORDER MONTHLY SUM
    *
    * */

    var monthlyOrderIncome = widget.yearlyOrder
        .where((element) =>
            DateFormat.MMM()
                .format(DateTime.parse(element['date']))
                .toString() ==
            monthOfYear[widget.index])
        .toList();
    var totalMonthlyOrderPrice =
        monthlyOrderIncome.map((e) => e['totalAmount']).toList();

    var totMonthlyOrderSum = 0.0;
    for (int xx = 0; xx < totalMonthlyOrderPrice.length; xx++) {
      totMonthlyOrderSum += (double.parse(totalMonthlyOrderPrice[xx]));
    }

    /*
   *
   *
   * MONTHLY SHOP SOLD SUM
   *
   *
   *
   * */

    var monthlyShopSoldIncome = widget.yearlySold
        .where((element) =>
            DateFormat.MMM()
                .format(DateTime.parse(element['date']))
                .toString() ==
            monthOfYear[widget.index])
        .toList();

    /*


                  BALE 5
                *
                *
                *
                * */
    var totalEmployeeSoldBale_5 =
        monthlyShopSoldIncome.map((e) => e['bale_5']).toList();

    var totalEmployeeSoldSumBale_5 = 0;
    for (int xx = 0; xx < totalEmployeeSoldBale_5.length; xx++) {
      totalEmployeeSoldSumBale_5 += int.parse(totalEmployeeSoldBale_5[xx]);
    }

    /*


                  BALE 10
                *
                *
                *
                * */
    var totalEmployeeSoldBale_10 =
        monthlyShopSoldIncome.map((e) => e['bale_10']).toList();

    var totalEmployeeSoldSumBale_10 = 0;
    for (int xx = 0; xx < totalEmployeeSoldBale_10.length; xx++) {
      totalEmployeeSoldSumBale_10 += int.parse(totalEmployeeSoldBale_10[xx]);
    }
    /*


                   SLICE
                *
                *
                *
                * */
    var totalEmployeeSoldSlice =
        monthlyShopSoldIncome.map((e) => e['slice']).toList();

    var totalEmployeeSoldSumSlice = 0;
    for (int xx = 0; xx < totalEmployeeSoldSlice.length; xx++) {
      totalEmployeeSoldSumSlice += int.parse(totalEmployeeSoldSlice[xx]);
    }
    /*


                 BOMBOLINO
                *
                *
                *
                * */
    var totalEmployeeSoldBombolino =
        monthlyShopSoldIncome.map((e) => e['bombolino']).toList();

    var totalEmployeeSoldSumBombolino = 0;
    for (int xx = 0; xx < totalEmployeeSoldBombolino.length; xx++) {
      totalEmployeeSoldSumBombolino +=
          int.parse(totalEmployeeSoldBombolino[xx]);
    }
    /*
                *
                * TOTAL INCOME BALE_5
                *
                *
                * */
    final double totalBale_5 = totalEmployeeSoldSumBale_5 *
        (monthlyShopSoldIncome.isEmpty
            ? 0.0
            : double.parse(monthlyShopSoldIncome.last['bale_5_Sp']));
    /*
                *
                * TOTAL INCOME BALE_10
                *
                *
                * */
    final double totalBale_10 = totalEmployeeSoldSumBale_10 *
        (monthlyShopSoldIncome.isEmpty
            ? 0.0
            : double.parse(monthlyShopSoldIncome.last['bale_10_Sp']));
    /*
                *
                * TOTAL INCOME SLICE
                *
                *
                * */
    final double totalSlice = totalEmployeeSoldSumSlice *
        (monthlyShopSoldIncome.isEmpty
            ? 0.0
            : double.parse(monthlyShopSoldIncome.last['slice_Sp']));
    /*
                *
                * TOTAL INCOME BOMBOLINO
                *
                *
                * */
    final double totalBombolino = totalEmployeeSoldSumBombolino *
        (monthlyShopSoldIncome.isEmpty
            ? 0.0
            : double.parse(monthlyShopSoldIncome.last['bombolino_Sp']));
    double totalMonthlySold =
        (totalBale_5 + totalBale_10 + totalSlice + totalBombolino);
    double summaryMonthlyIncome =
        totalMonthlySold + totMonthlyOrderSum + totMonthlyContratSum;

    double totalSummaryDetail(double sumIncome, double sumExpense) {
      totalSumation = sumIncome - sumExpense;
      if (totalSumation < 0) {
        totalSumation = totalSumation * (-1);
        isNegative = true;
        return totalSumation;
      } else {
        isNegative = false;
        return totalSumation;
      }
    }

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
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
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(3, 83, 151, 1),
                    const Color.fromRGBO(3, 83, 151, 1).withOpacity(0.9)
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
                      : 130
                  : isExpanded
                      ? 200
                      : 205,
              width: isExpanded ? 345 : 350,
              child: isTapped
                  ? Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 25, bottom: 25, left: 5),
                            child: Center(
                              child: Text(
                                monthOfYear[widget.index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Income',
                                        style: kkSummaryIncome,
                                      ),
                                      Text(
                                        '$summaryMonthlyIncome',
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
                                        'Expense',
                                        style: kkSummaryExpense,
                                      ),
                                      Text('$totMonthlyExpenseSum',
                                          style: kkSummaryExpense),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 2,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Profit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '${totalSummaryDetail(summaryMonthlyIncome, totMonthlyExpenseSum)}',
                                        style: TextStyle(
                                          color: isNegative
                                              ? Colors.red
                                              : Colors.green,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
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
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 20, left: 5),
                                child: Center(
                                  child: Text(
                                    monthOfYear[widget.index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 5),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Income',
                                            style: kkSummaryIncome,
                                          ),
                                          Text(
                                            '$summaryMonthlyIncome',
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
                                            'Expense',
                                            style: kkSummaryExpense,
                                          ),
                                          Text(
                                            '$totMonthlyExpenseSum',
                                            style: kkSummaryExpense,
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Profit',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            '${totalSummaryDetail(summaryMonthlyIncome, totMonthlyExpenseSum)}',
                                            style: TextStyle(
                                              color: isNegative
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18,
                                            ),
                                          ),
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => SellerDetail(
                                              selectedMonth: widget.index + 1),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Income Detail',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => SummaryExpenseList(
                                            month: monthOfYear[widget.index],
                                            selectedCurrentYear:
                                                widget.currentYear,
                                            summaryDataList:
                                                widget.yearlyExpense,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Expense Detail',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //   SummaryExpenseList(index: widget.index,listMonth: monthOfYear,)
                            ],
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
