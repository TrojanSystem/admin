import 'package:ada_bread/dataHub/data/daily_production_data.dart';
import 'package:ada_bread/production_screen/production_input.dart';
import 'package:ada_bread/production_screen/progress_indicator.dart';
import 'package:ada_bread/production_screen/slideshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final bale_5 = Provider.of<DailyProductionData>(context).totalBale_5;
    final bale_10 = Provider.of<DailyProductionData>(context).totalBale_10;
    final slice = Provider.of<DailyProductionData>(context).totalSlice;
    final bombolino = Provider.of<DailyProductionData>(context).totalBombolino;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Slide(
                bale_5: bale_5,
                bale_10: bale_10,
                bombolino: bombolino,
                slice: slice),
          ),
          Expanded(
            flex: 4,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('DailySell')
                    .snapshots(),
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
                      dailyProductionDayFilter
                          .map((e) => e['bale_10'])
                          .toList();

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
                  for (int xx = 0;
                      xx < totalEmployeeSoldSliceForAdmin.length;
                      xx++) {
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
                      dailyProductionDayFilter
                          .map((e) => e['bombolino'])
                          .toList();

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
                              : double.parse(dailyProductionDayFilter
                                  .last['bombolino_Sp']));
                  final listOfPriceForAdmin = [
                    {
                      'image': 'images/bale_5.png',
                      'produced': '$totalEmployeeSoldSumBale_5ForAdmin',
                    },
                    {
                      'image': 'images/bale_10.png',
                      'produced': '$totalEmployeeSoldSumBale_10ForAdmin',
                    },
                    {
                      'image': 'images/slice.png',
                      'produced': '$totalEmployeeSoldSumSliceForAdmin',
                    },
                    {
                      'image': 'images/donut.png',
                      'produced': '$totalEmployeeSoldSumBombolinoForAdmin',
                    }
                  ];
                  return ListView(
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
                                  soldItem: '50',
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
                  );
                }),
          )
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => DropDownMenuButton(
            primaryColor: Colors.red,
            button_1: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const ProductionInput(),
              ));
            },
            button_2: () {},
            button_3: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const ItemDetails(),
              ));
            },
            button_4: () {}),
      ),
    );
  }
}
