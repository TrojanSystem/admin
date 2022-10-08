import 'package:ada_bread/order_screen/dfo_order.dart';
import 'package:ada_bread/order_screen/order_list_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../dataHub/data/data_storage.dart';
import '../dataHub/data/order_data_hub.dart';
import '../drop_down_menu_button.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future _callContact(BuildContext context, String number) async {
    final url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      const snackbar = SnackBar(content: Text('Can\'t make a call'));
      //  Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  Future _smsContact(BuildContext context, String number) async {
    final url = 'sms:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      const snackbar = SnackBar(content: Text('Can\'t make a Message'));
      //Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  int selectedDayOfMonth = DateTime.now().day;
  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderDataHub>(context).orderList;
    final monthSelected = Provider.of<DataStorage>(context).daysOfMonth;
    final result = orderList
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();

    var todayMonthFilteredList = result
        .where((element) =>
            DateTime.parse(element.date).month == DateTime.now().month)
        .toList();
    var dailyOrder = todayMonthFilteredList
        .where(
            (element) => DateTime.parse(element.date).day == selectedDayOfMonth)
        .toList();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              dropdownColor: Colors.grey[850],
              iconEnabledColor: Colors.white,
              menuMaxHeight: 300,
              value: selectedDayOfMonth,
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
                  selectedDayOfMonth = value;
                });
              },
            ),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: dailyOrder.isEmpty
          ? Center(
              child: Image.asset(
                'images/no_order.png',
                width: 200,
              ),
            )
          : ListView.builder(
              itemCount: dailyOrder.length,
              itemBuilder: (context, index) {
                double payedBirr = double.parse(dailyOrder[index].totalAmount) -
                    double.parse(dailyOrder[index].remain);
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      IconButton(
                        color: Colors.green,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      IconButton(
                        color: Colors.red,
                        onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Are you sure'),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: const Text('No'),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                            content: const Text(
                                'Do you want to remove the Labour from the List?'),
                          ),
                        ),
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
                        onPressed: () => _callContact(
                            context, dailyOrder[index].phoneNumber),
                        icon: const Icon(
                          Icons.call,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        color: Colors.blue,
                        onPressed: () => _smsContact(
                          context,
                          dailyOrder[index].phoneNumber,
                        ),
                        icon: const Icon(
                          Icons.message_rounded,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 18.0, 8, 0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 4,
                                offset: const Offset(
                                    4, 8), // changes position of shadow
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: 120,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 40, left: 20),
                                        child: Text(
                                          dailyOrder[index].name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 20),
                                        child: Text(
                                          dailyOrder[index].phoneNumber,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          dailyOrder[index].totalAmount,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Text(
                                          'ETB',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8.0, 10, 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              Icons.access_time_filled_rounded,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              DateFormat.E().add_jm().format(
                                                    DateTime.parse(
                                                        dailyOrder[index].date),
                                                  ),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Payed: ${payedBirr}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            'Remain: ${dailyOrder[index].remain}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 130,
                            height: 33,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${orderList[index].orderedKilo} KG',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ', ${orderList[index].pricePerKG} / KG',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
      floatingActionButton: Builder(
        builder: (context) => DropDownMenuButton(
            primaryColor: Colors.red,
            button_1: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const DfoOrder(),
                ),
              );
            },
            button_2: () {},
            button_3: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const OrderListItem(),
                ),
              );
            },
            button_4: () {}),
      ),
    );
  }
}
