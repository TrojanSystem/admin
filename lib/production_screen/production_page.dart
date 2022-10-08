import 'package:ada_bread/dataHub/data/daily_production_data.dart';
import 'package:ada_bread/production_screen/production_input.dart';
import 'package:ada_bread/production_screen/progress_indicator.dart';
import 'package:ada_bread/production_screen/slideshow.dart';
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
    final dailyProducedItem =
        Provider.of<DailyProductionData>(context).productionList;

    dailyProducedItem.sort();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Slide(production: dailyProducedItem),
          ),
          Expanded(
            flex: 4,
            child: ListView(
              children: [
                SizedBox(
                  width: 500,
                  height: 80,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'images/bale_5.png',
                        width: 45,
                        height: 45,
                      ),
                      ProgressContainerItem(
                        soldItem: '500',
                        dailyProducedItem: dailyProducedItem.isEmpty
                            ? '0'
                            : dailyProducedItem.first.bale_5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 500,
                  height: 80,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'images/bale_10.png',
                        width: 45,
                        height: 45,
                      ),
                      ProgressContainerItem(
                        soldItem: '10',
                        dailyProducedItem: dailyProducedItem.isEmpty
                            ? '0'
                            : dailyProducedItem.first.bale_10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 500,
                  height: 80,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'images/slice.png',
                        width: 45,
                        height: 45,
                      ),
                      ProgressContainerItem(
                        soldItem: '0',
                        dailyProducedItem: dailyProducedItem.isEmpty
                            ? '0'
                            : dailyProducedItem.first.slice,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 500,
                  height: 80,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'images/donut.png',
                        width: 45,
                        height: 45,
                      ),
                      ProgressContainerItem(
                        soldItem: '12',
                        dailyProducedItem: dailyProducedItem.isEmpty
                            ? '0'
                            : dailyProducedItem.first.bombolino,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
