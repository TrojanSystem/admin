import 'package:ada_bread/production_screen/production_input.dart';
import 'package:ada_bread/production_screen/progress_indicator.dart';
import 'package:ada_bread/production_screen/slideshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dataHub/data/production_data_hub.dart';
import '../data_provider.dart';
import '../drop_down_menu_button.dart';
import 'contract_list.dart';

class ProductionPage extends StatefulWidget {
  const ProductionPage({Key key}) : super(key: key);

  @override
  State<ProductionPage> createState() => _ProductionPageState();
}

class _ProductionPageState extends State<ProductionPage> {
  final List<String> images = [
    'images/bale_5.png',
    'images/bale_10.png',
    'images/slice.png',
    'images/donut.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('DailySell').snapshots(),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
              );
            }
            final dailyProductionData = snapShot.data.docs;
            final yearFilter =
                Provider.of<ProductionModelData>(context).contractList;
            final monthFilterList = yearFilter
                .where((element) =>
                    DateTime.parse(element['date']).year == DateTime.now().year)
                .toList();
            var monthFilteredContractList = monthFilterList
                .where((element) =>
                    DateTime.parse(element['date']).month ==
                    DateTime.now().month)
                .toList();
            var todayFilteredContractList = monthFilteredContractList
                .where((element) =>
                    DateTime.parse(element['date']).day == DateTime.now().day)
                .toList();
            var totalContractGivenQuantity =
                todayFilteredContractList.map((e) => e['quantity']).toList();
            int totContractGivenQuantity = 0;
            for (int xx = 0; xx < totalContractGivenQuantity.length; xx++) {
              totContractGivenQuantity +=
                  int.parse(totalContractGivenQuantity[xx]);
            }

/***
 *
 *
 * EXPENSE list
 * */
            final expense = Provider.of<DataProvider>(context).expenseList;

            final employeeExpenseYearFilter = expense
                .where((element) =>
                    DateTime.parse(element['itemDate']).year ==
                    DateTime.now().year)
                .toList();

            var employeeExpenseMonthFilter = employeeExpenseYearFilter
                .where((element) =>
                    DateTime.parse(element['itemDate']).month ==
                    DateTime.now().month)
                .toList();
            var employeeExpenseDayFilter = employeeExpenseMonthFilter
                .where((element) =>
                    DateTime.parse(element['itemDate']).day ==
                    DateTime.now().day)
                .toList();

            /***
             *
             *
             *
             *
             *
             */

            final dailyProduction = dailyProductionData
                .where((element) =>
                    DateTime.parse(element['producedDate']).year ==
                    DateTime.now().year)
                .toList();

            var dailyProductionMonthFilter = dailyProduction
                .where((element) =>
                    DateTime.parse(element['producedDate']).month ==
                    DateTime.now().month)
                .toList();
            var dailyProductionDayFilter = dailyProductionMonthFilter
                .where((element) =>
                    DateTime.parse(element['producedDate']).day ==
                    DateTime.now().day)
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
                dailyProductionDayFilter.map((e) => e['bale_5']).toList();

            var totalEmployeeSoldSumBale_5ForAdmin = 0;
            for (int xx = 0;
                xx < totalEmployeeSoldBale_5ForAdmin.length;
                xx++) {
              totalEmployeeSoldSumBale_5ForAdmin +=
                  int.parse(totalEmployeeSoldBale_5ForAdmin[xx]);
            }

            /*


                  BALE 10 ForAdmin
                *
                *
                *
                * */
            var totalEmployeeSoldBale_10ForAdmin =
                dailyProductionDayFilter.map((e) => e['bale_10']).toList();

            var totalEmployeeSoldSumBale_10ForAdmin = 0;
            for (int xx = 0;
                xx < totalEmployeeSoldBale_10ForAdmin.length;
                xx++) {
              totalEmployeeSoldSumBale_10ForAdmin +=
                  int.parse(totalEmployeeSoldBale_10ForAdmin[xx]);
            }
            /*


                   SLICE ForAdmin
                *
                *
                *
                * */
            var totalEmployeeSoldSliceForAdmin =
                dailyProductionDayFilter.map((e) => e['slice']).toList();

            var totalEmployeeSoldSumSliceForAdmin = 0;
            for (int xx = 0; xx < totalEmployeeSoldSliceForAdmin.length; xx++) {
              totalEmployeeSoldSumSliceForAdmin +=
                  int.parse(totalEmployeeSoldSliceForAdmin[xx]);
            }
            /*


                 BOMBOLINO ForAdmin
                *
                *
                *
                * */
            var totalEmployeeSoldBombolinoForAdmin =
                dailyProductionDayFilter.map((e) => e['bombolino']).toList();

            var totalEmployeeSoldSumBombolinoForAdmin = 0;
            for (int xx = 0;
                xx < totalEmployeeSoldBombolinoForAdmin.length;
                xx++) {
              totalEmployeeSoldSumBombolinoForAdmin +=
                  int.parse(totalEmployeeSoldBombolinoForAdmin[xx]);
            }

            /*
                *
                * TOTAL EXPECTED INCOME BALE_5
                *
                *
                * */
            final double totalBale_5ForAdmin =
                totalEmployeeSoldSumBale_5ForAdmin *
                    (dailyProductionDayFilter.isEmpty
                        ? 0.0
                        : double.parse(
                            dailyProductionDayFilter.last['bale_5_Sp']));
            /*
                *
                * TOTAL EXPECTED INCOME BALE_10
                *
                *
                * */
            final double totalBale_10ForAdmin =
                totalEmployeeSoldSumBale_10ForAdmin *
                    (dailyProductionDayFilter.isEmpty
                        ? 0.0
                        : double.parse(
                            dailyProductionDayFilter.last['bale_10_Sp']));
            /*
                *
                * TOTAL EXPECTED INCOME SLICE
                *
                *
                * */
            final double totalSliceForAdmin =
                totalEmployeeSoldSumSliceForAdmin *
                    (dailyProductionDayFilter.isEmpty
                        ? 0.0
                        : double.parse(
                            dailyProductionDayFilter.last['slice_Sp']));
            /*
                *
                * TOTAL EXPECTED INCOME BOMBOLINO
                *
                *
                * */
            final double totalBombolinoForAdmin =
                totalEmployeeSoldSumBombolinoForAdmin *
                    (dailyProductionDayFilter.isEmpty
                        ? 0.0
                        : double.parse(
                            dailyProductionDayFilter.last['bombolino_Sp']));

            /*
                *
                * SOLD ITEM
                *
                *
                * */
            final shopSold =
                Provider.of<DataProvider>(context).databaseDataForShop;

            final itemType = shopSold
                .where((element) => element['isWhat'] == 'sold')
                .toList();

            final employeeSoldYearFilter = itemType
                .where((element) =>
                    DateTime.parse(element['date']).year == DateTime.now().year)
                .toList();

            var employeeSoldMonthFilter = employeeSoldYearFilter
                .where((element) =>
                    DateTime.parse(element['date']).month ==
                    DateTime.now().month)
                .toList();
            var employeeSoldDayFilter = employeeSoldMonthFilter
                .where((element) =>
                    DateTime.parse(element['date']).day == DateTime.now().day)
                .toList();
            /*


                  BALE 5
                *
                *
                *
                * */
            var totalEmployeeSoldBale_5 =
                employeeSoldDayFilter.map((e) => e['bale_5']).toList();

            var totalEmployeeSoldSumBale_5 = 0;
            for (int xx = 0; xx < totalEmployeeSoldBale_5.length; xx++) {
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
                employeeSoldDayFilter.map((e) => e['bale_10']).toList();

            var totalEmployeeSoldSumBale_10 = 0;
            for (int xx = 0; xx < totalEmployeeSoldBale_10.length; xx++) {
              totalEmployeeSoldSumBale_10 +=
                  int.parse(totalEmployeeSoldBale_10[xx]);
            }
            /*


                   SLICE
                *
                *
                *
                * */
            var totalEmployeeSoldSlice =
                employeeSoldDayFilter.map((e) => e['slice']).toList();

            var totalEmployeeSoldSumSlice = 0;
            for (int xx = 0; xx < totalEmployeeSoldSlice.length; xx++) {
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
                employeeSoldDayFilter.map((e) => e['bombolino']).toList();

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
                (employeeSoldDayFilter.isEmpty
                    ? 0.0
                    : double.parse(employeeSoldDayFilter.last['bale_5_Sp']));
            /*
                *
                * TOTAL INCOME BALE_10
                *
                *
                * */
            final double totalBale_10 = totalEmployeeSoldSumBale_10 *
                (employeeSoldDayFilter.isEmpty
                    ? 0.0
                    : double.parse(employeeSoldDayFilter.last['bale_10_Sp']));
            /*
                *
                * TOTAL INCOME SLICE
                *
                *
                * */
            final double totalSlice = totalEmployeeSoldSumSlice *
                (employeeSoldDayFilter.isEmpty
                    ? 0.0
                    : double.parse(employeeSoldDayFilter.last['slice_Sp']));
            /*
                *
                * TOTAL INCOME BOMBOLINO
                *
                *
                * */
            final double totalBombolino = totalEmployeeSoldSumBombolino *
                (employeeSoldDayFilter.isEmpty
                    ? 0.0
                    : double.parse(employeeSoldDayFilter.last['bombolino_Sp']));

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
                'sold':
                    '${totalEmployeeSoldSumBale_5 + totContractGivenQuantity}',
                'produced': '$totalEmployeeSoldSumBale_5ForAdmin',
              },
              {
                'image': 'images/bale_10.png',
                'sold': '$totalEmployeeSoldSumBale_10',
                'produced': '$totalEmployeeSoldSumBale_10ForAdmin',
              },
              {
                'image': 'images/slice.png',
                'sold': '$totalEmployeeSoldSumSlice',
                'produced': '$totalEmployeeSoldSumSliceForAdmin',
              },
              {
                'image': 'images/donut.png',
                'sold': '$totalEmployeeSoldSumBombolino',
                'produced': '$totalEmployeeSoldSumBombolinoForAdmin',
              }
            ];
            double totalProducedItemIncome = (totalBombolinoForAdmin +
                totalSliceForAdmin +
                totalBale_10ForAdmin +
                totalBale_5ForAdmin);
            int totalSoldItemIncome = (totalEmployeeSoldSumBombolino +
                totalEmployeeSoldSumBale_5 +
                totalEmployeeSoldSumBale_10 +
                totalEmployeeSoldSumSlice);

            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Slide(
                      soldBale_5: totalEmployeeSoldSumBale_5.toString(),
                      soldBale_10: totalEmployeeSoldSumBale_10.toString(),
                      soldSlice: totalEmployeeSoldSumSlice.toString(),
                      soldBombolino: totalEmployeeSoldSumBombolino.toString(),
                      bale_5: totalEmployeeSoldSumBale_5ForAdmin.toString(),
                      bale_10: totalEmployeeSoldSumBale_10ForAdmin.toString(),
                      bombolino:
                          totalEmployeeSoldSumBombolinoForAdmin.toString(),
                      slice: totalEmployeeSoldSumSliceForAdmin.toString(),
                      soldIncomeBale_5: totalBale_5.toString(),
                      soldIncomeBombolino: totalBombolino.toString(),
                      soldIncomeSlice: totalSlice.toString(),
                      soldIncomeBale_10: totalBale_10.toString(),
                      totProducedIncome: totalProducedItemIncome,
                      totSoldIncome: totalSoldItemIncome),
                ),
                Expanded(
                  flex: 4,
                  child: ListView(
                    children: listOfPriceForAdmin
                        .map(
                          (e) => SizedBox(
                            width: 500,
                            height: 80,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  e['image'],
                                  width: 45,
                                  height: 45,
                                ),
                                ProgressContainerItem(
                                  soldItem: e['sold'],
                                  dailyProducedItem:
                                      dailyProductionDayFilter.isEmpty
                                          ? '0'
                                          : e['produced'],
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            );
          }),
      floatingActionButton: Builder(
        builder: (context) => DropDownMenuButton(
          primaryColor: Colors.red,
          button_1: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ProductionInput(),
              ),
            );
          },
          button_2: () {},
          button_3: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ItemDetails(),
              ),
            );
          },
        ),
      ),
    );
  }
}
