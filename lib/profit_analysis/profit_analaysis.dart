import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class ProfitAnalaysis extends StatefulWidget {
  final int index;
  final int currentYear;
  final List yearlyExpense;
  final List yearlyContrat;
  final List yearlyOrder;

  ProfitAnalaysis(
      {this.index,
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
                .format(DateTime.parse(element.itemDate))
                .toString() ==
            monthOfYear[widget.index])
        .toList();
    var totalMonthlyExpenses = monthlyExpense.map((e) => e.itemPrice).toList();

    var totMonthlyExpenseSum = 0.0;
    for (int xx = 0; xx < totalMonthlyExpenses.length; xx++) {
      totMonthlyExpenseSum += double.parse(totalMonthlyExpenses[xx]);
    }

    /*
    *
    *
    *
    *
    *
    *
    *
    * */
    var monthlyContract = widget.yearlyContrat
        .where((element) =>
            DateFormat.MMM().format(DateTime.parse(element.date)).toString() ==
            monthOfYear[widget.index])
        .toList();
    double totPriceDabo = 0;
    var quantityOfBread = monthlyContract.map((e) => e.quantity).toList();
    double sumDabo = 0;
    var totDaboDelivered = monthlyContract.map((e) => e.quantity).toList();

    for (int x = 0; x < totDaboDelivered.length; x++) {
      sumDabo += int.parse(totDaboDelivered[x]);
    }
    var priceOfBread = monthlyContract.map((e) => e.price).toList();
    for (int x = 0; x < quantityOfBread.length; x++) {
      totPriceDabo +=
          double.parse(quantityOfBread[x]) * double.parse(priceOfBread[x]);
    }

    /*
    *
    *
    *
    *
    *
    *
    *
    * */

    var monthlyOrder = widget.yearlyOrder
        .where((element) =>
            DateFormat.MMM().format(DateTime.parse(element.date)).toString() ==
            monthOfYear[widget.index])
        .toList();
    double totOrderedKg = 0;
    double totPriceOrder = 0;
    var quantityOfDfo = monthlyOrder.map((e) => e.orderedKilo).toList();

    var priceOfDfo = monthlyOrder.map((e) => e.totalAmount).toList();
    for (int x = 0; x < priceOfDfo.length; x++) {
      totPriceOrder += double.parse(priceOfDfo[x]);
    }
    for (int x = 0; x < quantityOfDfo.length; x++) {
      totOrderedKg += double.parse(quantityOfDfo[x]);
    }

    /*
    *
    *
    *
    *
    *
    *
    *
    * */

    final summaryDataSold = 23000;
    double totalSummary(double totExpenseSum, double totIncomeSum, tot) {
      double totalSummary = totExpenseSum + totIncomeSum + tot;
      return totalSummary;
    }

    // final filtereByYearForExpense = summaryExpenseDataList
    //     .where((element) =>
    //         DateTime.parse(element.itemDate).year == widget.currentYear)
    //     .toList();
    // final filtereByYearForSell = summarySellingDataList
    //     .where((element) =>
    //         DateTime.parse(element.itemDate).year == widget.currentYear)
    //     .toList();
    //
    // var monthExpense = filtereByYearForExpense
    //     .where((element) =>
    //         DateFormat.MMM()
    //             .format(DateTime.parse(element.itemDate))
    //             .toString() ==
    //         monthOfYear[widget.index])
    //     .toList();
    // var monthExpenseSummary = monthExpense.map((e) => e.itemPrice).toList();
    // var sumExpense = 0.0;
    // for (int x = 0; x < monthExpenseSummary.length; x++) {
    //   sumExpense += double.parse(monthExpenseSummary[x]);
    // }
    //
    // var monthIncome = filtereByYearForSell
    //     .where((element) =>
    //         DateFormat.MMM()
    //             .format(DateTime.parse(element.itemDate))
    //             .toString() ==
    //         monthOfYear[widget.index])
    //     .toList();
    //
    // var monthIncomeSummaryQuantity =
    //     monthIncome.map((e) => e.itemQuantity).toList();
    // var monthIncomeSummary = monthIncome.map((e) => e.itemPrice).toList();
    // var sumIncomes = 0.0;
    // for (int x = 0; x < monthIncomeSummary.length; x++) {
    //   sumIncomes += (double.parse(monthIncomeSummary[x]) *
    //       double.parse(monthIncomeSummaryQuantity[x]));
    // }
    //
    // final dataForProfit =
    //     Provider.of<ProfitModelData>(context, listen: false).profitList;
    // final dataForMonth = dataForProfit
    //     .where((element) =>
    //         DateTime.parse(element.itemDate).year == widget.currentYear)
    //     .toList();
    //
    // var data = dataForMonth
    //     .where((element) =>
    //         DateFormat.MMM()
    //             .format(DateTime.parse(element.itemDate))
    //             .toString() ==
    //         monthOfYear[widget.index])
    //     .toList();
    // final profitStorePrice = data.map((e) => e.storePrice).toList();
    // final profitSoldQuantity = data.map((e) => e.sellQuantity).toList();
    // var profitSum = 0.0;
    // for (int finals = 0; finals < data.length; finals++) {
    //   profitSum += (double.parse(profitStorePrice[finals]) *
    //       double.parse(profitSoldQuantity[finals]));
    // }
    double sumIncome = 0.00;

    sumIncome = totalSummary(totPriceOrder, totPriceDabo, summaryDataSold);

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
                                '${monthOfYear[widget.index]}',
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
                                        '${totalSummary(totPriceOrder, totPriceDabo, summaryDataSold)}',
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
                                        '${totalSummaryDetail(sumIncome, totMonthlyExpenseSum)}',
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
                                    'monthOfYear',
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
                                            'sumIncome',
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
                                          Text('sumExpense',
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
                                            'totalSummaryDetail',
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
                                    onPressed: () {},
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
                                    onPressed: () {},
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
