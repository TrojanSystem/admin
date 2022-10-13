import 'package:ada_bread/production_screen/income.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../dataHub/data/data_storage.dart';
import '../dataHub/data/production_data_hub.dart';
import 'expense.dart';

class ContractListDetail extends StatefulWidget {
  final double totPrice;
  final double total;
  const ContractListDetail({this.total, this.totPrice});

  @override
  State<ContractListDetail> createState() => _ContractListDetailState();
}

class _ContractListDetailState extends State<ContractListDetail> {
  int selectedMonthForList = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    final monthSelectedForList = Provider.of<DataStorage>(context).monthOfAYear;
    final yearFilter = Provider.of<ProductionModelData>(context).contractList;
    final monthFilterList = yearFilter
        .where((element) =>
            DateTime.parse(element['date']).year == DateTime.now().year)
        .toList();
    var todayFilteredContratList = monthFilterList
        .where((element) =>
            DateTime.parse(element['date']).month == selectedMonthForList)
        .toList();
    var totalContratGivenPrice =
        todayFilteredContratList.map((e) => e['price']).toList();
    var totalContratGivenQuantity =
        todayFilteredContratList.map((e) => e['quantity']).toList();

    var totContratGivenSum = 0.00;
    for (int xx = 0; xx < totalContratGivenPrice.length; xx++) {
      totContratGivenSum += (double.parse(totalContratGivenPrice[xx]) *
          double.parse(totalContratGivenQuantity[xx]));
    }
    var totContratGivenQuantity = 0.00;
    for (int xx = 0; xx < totalContratGivenPrice.length; xx++) {
      totContratGivenQuantity += double.parse(totalContratGivenQuantity[xx]);
    }
    var filterName =
        todayFilteredContratList.map((e) => e['name']).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color.fromRGBO(40, 53, 147, 1),
              const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          ),
        ),
        title: const Text('የኮትራት ዝርዝር'),
        actions: [
          DropdownButton(
            dropdownColor: Colors.grey[850],
            iconEnabledColor: Colors.white,
            menuMaxHeight: 300,
            value: selectedMonthForList,
            items: monthSelectedForList
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(
                      e['month'],
                      style: kkDropDown,
                    ),
                    value: e['days'],
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedMonthForList = value as int;
              });
            },
          ),
        ],
      ),
      body: Consumer<DataStorage>(
        builder: (context, data, child) => Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Income(totPrice: totContratGivenSum),
                  Expense(total: totContratGivenQuantity),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(_w / 30),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: filterName.length,
                  itemBuilder: (BuildContext context, int index) {
                    var filterName = todayFilteredContratList
                        .map((e) => e['name'])
                        .toSet()
                        .toList();
                    var todayFilteredContratListForQuantity = monthFilterList
                        .where(
                            (element) => element['name'] == filterName[index])
                        .toList();
                    var filterGivenPrice = todayFilteredContratListForQuantity
                        .map((e) => e['price'])
                        .toSet()
                        .toList();
                    double totalQuantity = 0;
                    for (int x = 0;
                        x < todayFilteredContratListForQuantity.length;
                        x++) {
                      totalQuantity += double.parse(
                          todayFilteredContratListForQuantity[x]['quantity']);
                    }
                    double totalPrice = 0;
                    for (int x = 0; x < filterGivenPrice.length; x++) {
                      totalPrice =
                          totalQuantity * double.parse(filterGivenPrice[x]);
                    }

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        horizontalOffset: -300,
                        verticalOffset: -850,
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              const SizedBox(
                                width: 50,
                              ),
                              IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('ContratGiven')
                                      .doc(filterName[index])
                                      .delete();
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                color: Colors.green,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          totalPrice.toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'ETB',
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          filterName[index],
                                        ),
                                      ),
                                      subtitle: Text(
                                        DateFormat.yMMMEd().format(
                                          DateTime.now(),
                                        ),
                                      ),
                                      trailing: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Dabo',
                                            style: TextStyle(
                                              color: Colors.green[800],
                                              fontFamily: 'FjallaOne',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                            totalQuantity.toString(),
                                            style: TextStyle(
                                              color: Colors.green[800],
                                              fontFamily: 'FjallaOne',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(bottom: _w / 20),
                            height: _w / 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
