import 'package:ada_bread/production_screen/contract_pdf_report.dart';
import 'package:ada_bread/production_screen/contrat_input.dart';
import 'package:ada_bread/production_screen/expense.dart';
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
import '../drop_down_menu_button.dart';
import 'contract_list_detail.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  double totPriceDabo = 0;
  double sumDabo = 0;
  int selectedMonth = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    final monthSelected = Provider.of<DataStorage>(context).daysOfMonth;
    final List contrat = Provider.of<ProductionModelData>(context).contractList;

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
        title: const Text('የቀን ኮትራት የተሰጠ ዝርዝር'),
        actions: [
          DropdownButton(
            dropdownColor: Colors.grey[850],
            iconEnabledColor: Colors.white,
            menuMaxHeight: 300,
            value: selectedMonth,
            items: monthSelected
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
                selectedMonth = value as int;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('ContratGiven').snapshots(),
          builder: (context, contratList) {
            if (!contratList.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
              );
            }
            final contratData = contratList.data.docs;
            final monthFilterList = contratData
                .where((element) =>
                    DateTime.parse(element['date']).year == DateTime.now().year)
                .toList();
            var monthFilteredContratList = monthFilterList
                .where((element) =>
                    DateTime.parse(element['date']).month ==
                    DateTime.now().month)
                .toList();
            var todayFilteredContratList = monthFilteredContratList
                .where((element) =>
                    DateTime.parse(element['date']).day == selectedMonth)
                .toList();

            totPriceDabo = 0;

            var quantityOfBread =
                todayFilteredContratList.map((e) => e['quantity']).toList();
            sumDabo = 0;
            var totDaboDelivered =
                todayFilteredContratList.map((e) => e['quantity']).toList();

            for (int x = 0; x < totDaboDelivered.length; x++) {
              sumDabo += int.parse(totDaboDelivered[x]);
            }
            var priceOfBread =
                todayFilteredContratList.map((e) => e['price']).toList();
            for (int x = 0; x < quantityOfBread.length; x++) {
              totPriceDabo += double.parse(quantityOfBread[x]) *
                  double.parse(priceOfBread[x]);
            }
            final newDailyContract = todayFilteredContratList
                .map(
                  (e) => ContractPDFReport(
                    name: e['name'],
                    quantity: e['quantity'],
                    price: totPriceDabo.toString(),
                    date: DateFormat.yMMMEd().format(
                      DateTime.parse(e['date']),
                    ),
                  ),
                )
                .toList();
            Provider.of<FileHandlerForContract>(context, listen: false)
                .fileList = newDailyContract;
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Income(totPrice: totPriceDabo),
                      Expense(total: sumDabo),
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
                      itemCount: todayFilteredContratList.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                    onPressed: () {},
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              todayFilteredContratList[index]
                                                  ['price'],
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              todayFilteredContratList[index]
                                                  ['name'],
                                            ),
                                          ),
                                          subtitle: Text(
                                            DateFormat.yMMMEd().format(
                                              DateTime.parse(
                                                  todayFilteredContratList[
                                                      index]['date']),
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
                                                todayFilteredContratList[index]
                                                        ['quantity']
                                                    .toString(),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
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
            );
          }),
      floatingActionButton: Builder(
        builder: (context) => DropDownMenuButton(
          primaryColor: Colors.red,
          button_1: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ContratInput(),
              ),
            );
          },
          button_2: () {
            setState(() {
              Provider.of<FileHandlerForContract>(context, listen: false)
                  .createTable();
            });
          },
          button_3: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) =>
                    ContractListDetail(totPrice: totPriceDabo, total: sumDabo),
              ),
            );
          },
        ),
      ),
    );
  }
}
