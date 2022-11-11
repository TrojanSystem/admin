import 'package:ada_bread/dataHub/data/data_storage.dart';
import 'package:ada_bread/dataHub/data/order_data_hub.dart';
import 'package:ada_bread/data_provider.dart';
import 'package:ada_bread/profit_analysis/profit_analaysis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ProfitAnalaysisScreen extends StatefulWidget {
  ProfitAnalaysisScreen({@required this.summaryDataExpense});
  List summaryDataExpense;
  @override
  State<ProfitAnalaysisScreen> createState() => _ProfitAnalaysisScreenState();
}

class _ProfitAnalaysisScreenState extends State<ProfitAnalaysisScreen> {
  int currentYear = DateTime.now().year;
  double totalSumation = 0.00;
  bool isNegative = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<DataStorage>(context).currentYear = currentYear;

    final filterByYearExpense = widget.summaryDataExpense
        .where((element) =>
            DateTime.parse(element['itemDate']).year == currentYear)
        .toList();

    var totalExpenses = filterByYearExpense.map((e) => e['itemPrice']).toList();

    var totalQuantity =
        filterByYearExpense.map((e) => e['itemQuantity']).toList();

    var totExpenseSum = 0.00;
    for (int xx = 0; xx < totalExpenses.length; xx++) {
      totExpenseSum +=
          (double.parse(totalExpenses[xx]) * double.parse(totalQuantity[xx]));
    }
/*
*
*
*
* INCOME LIST
*
*
*
* */

    /*
    *
    *
    * CONTRAT GIVEN INCOME
    *
    *
    * */
    final summaryContratData = Provider.of<DataProvider>(context).contractList;
    final filterByYearContrat = summaryContratData
        .where((element) => DateTime.parse(element['date']).year == currentYear)
        .toList();

    var totalContratGivenPrice =
        filterByYearContrat.map((e) => e['price']).toList();
    var totalContratGivenQuantity =
        filterByYearContrat.map((e) => e['quantity']).toList();

    var totContratGivenSum = 0.00;
    for (int xx = 0; xx < totalContratGivenPrice.length; xx++) {
      totContratGivenSum += (double.parse(totalContratGivenPrice[xx]) *
          double.parse(totalContratGivenQuantity[xx]));
    }

    /*
    *
    *
    * ORDER RECEIVED INCOME
    *
    *
    * */
    final summaryOrderData = Provider.of<OrderDataHub>(context).orderList;
    final filterByYearOrder = summaryOrderData
        .where((element) => DateTime.parse(element['date']).year == currentYear)
        .toList();
    var totalOrderReceivedPrice =
        filterByYearOrder.map((e) => e['totalAmount']).toList();

    var totOrderReceivedSum = 0.00;
    for (int xx = 0; xx < totalOrderReceivedPrice.length; xx++) {
      totOrderReceivedSum += (double.parse(totalOrderReceivedPrice[xx]));
    }

    /*
    *
    *
    * INCOME AT SHOP SOLD BREAD
    *
    *
    * */
    final summaryShopSoldData =
        Provider.of<DataProvider>(context).databaseDataForShop;
    final itemType = summaryShopSoldData
        .where((element) => element['isWhat'] == 'sold')
        .toList();
    final employeeSoldYearFilter = itemType
        .where((element) => DateTime.parse(element['date']).year == currentYear)
        .toList();

    /*


                  BALE 5
                *
                *
                *
                * */
    var totalEmployeeSoldBale_5 =
        employeeSoldYearFilter.map((e) => e['bale_5']).toList();

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
        employeeSoldYearFilter.map((e) => e['bale_10']).toList();

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
        employeeSoldYearFilter.map((e) => e['slice']).toList();

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
        employeeSoldYearFilter.map((e) => e['bombolino']).toList();

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
        (employeeSoldYearFilter.isEmpty
            ? 0.0
            : double.parse(employeeSoldYearFilter.last['bale_5_Sp']));
    /*
                *
                * TOTAL INCOME BALE_10
                *
                *
                * */
    final double totalBale_10 = totalEmployeeSoldSumBale_10 *
        (employeeSoldYearFilter.isEmpty
            ? 0.0
            : double.parse(employeeSoldYearFilter.last['bale_10_Sp']));
    /*
                *
                * TOTAL INCOME SLICE
                *
                *
                * */
    final double totalSlice = totalEmployeeSoldSumSlice *
        (employeeSoldYearFilter.isEmpty
            ? 0.0
            : double.parse(employeeSoldYearFilter.last['slice_Sp']));
    /*
                *
                * TOTAL INCOME BOMBOLINO
                *
                *
                * */
    final double totalBombolino = totalEmployeeSoldSumBombolino *
        (employeeSoldYearFilter.isEmpty
            ? 0.0
            : double.parse(employeeSoldYearFilter.last['bombolino_Sp']));
    double totalSold =
        (totalBale_5 + totalBale_10 + totalSlice + totalBombolino);

    double summaryIncome = 0.0;

    summaryIncome = totContratGivenSum + totalSold + totOrderReceivedSum;

    double totalProfitSummary(double totExpenseSum, double totIncomeSum) {
      totalSumation = totIncomeSum - totExpenseSum;
      if (totalSumation < 0) {
        totalSumation = totalSumation * (-1);
        isNegative = true;
        return totalSumation;
      } else {
        isNegative = false;
        return totalSumation;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1).withOpacity(0.9),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color.fromRGBO(3, 83, 151, 1).withOpacity(0.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentYear -= 1;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          currentYear.toString(),
                          style: kkSummaryStyle,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentYear = currentYear + 1;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Income',
                          style: kkSummaryStyleTab,
                        ),
                        Text(
                          '$summaryIncome',
                          style: kkSummaryIncome,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Expense',
                          style: kkSummaryStyleTab,
                        ),
                        Text(
                          '$totExpenseSum',
                          style: kkSummaryExpenseStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 10),
                    child: Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Profit',
                          style: kkSummaryStyleTab,
                        ),
                        Text(
                          '${totalProfitSummary(totExpenseSum, summaryIncome)}',
                          style: TextStyle(
                            color: isNegative ? Colors.red : Colors.green,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                return ProfitAnalaysis(
                  currentYear: currentYear,
                  index: index,
                  yearlyContrat: filterByYearContrat,
                  yearlyExpense: filterByYearExpense,
                  yearlyOrder: filterByYearOrder,
                  yearlySold: employeeSoldYearFilter,
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
