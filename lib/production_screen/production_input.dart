import 'package:ada_bread/dataHub/data/daily_production_data.dart';
import 'package:ada_bread/dataHub/data_model/production_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductionInput extends StatefulWidget {
  const ProductionInput({Key key}) : super(key: key);

  @override
  State<ProductionInput> createState() => _ProductionInputState();
}

class _ProductionInputState extends State<ProductionInput> {
  final formKey = GlobalKey<FormState>();
  String bale_5_SP = '';
  String bale_10_SP = '';
  String slice_SP = '';
  String bombolino_SP = '';
  String bale_5 = '';
  String bale_10 = '';
  String slice = '';
  String bombolino = '';
  String dateTime = DateTime.now().toString();
  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then((value) => setState(() {
          if (value != null) {
            dateTime = value.toString();
          } else {
            dateTime = DateTime.now().toString();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('የእለት ምርት'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 12, 10, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ባለ 5 ብር',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Daily production can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            bale_5 = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter daily production',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'መሸጫ',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Daily production can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            bale_5_SP = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter SP',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 12, 10, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ባለ 10 ብር',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Daily production can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            bale_10 = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter daily production',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'መሸጫ',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Daily production can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            bale_10_SP = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter SP',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 12, 10, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ስላይስ',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Daily production can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            slice = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter daily production',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'መሸጫ',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Daily production can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            slice_SP = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter SP',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 12, 10, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ቦምቦሊኖ',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Daily production can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            bombolino = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter daily production',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'መሸጫ',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Daily production can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            bombolino_SP = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter SP',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        width: 250,
                        height: 60,
                        child: Text(
                          'Date is set to : ${DateFormat.yMEd().format(DateTime.parse(dateTime))}',
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            datePicker();
                          });
                        },
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //button
            GestureDetector(
              onTap: () {
                setState(() {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    final addDailyProduct = ProductionModel(
                        bale_5_Sp: bale_5_SP,
                        bale_10_Sp: bale_10_SP,
                        slice_Sp: slice_SP,
                        bombolino_Sp: bombolino_SP,
                        bale_5: bale_5,
                        bale_10: bale_10,
                        slice: slice,
                        bombolino: bombolino,
                        producedDate: dateTime);
                    Provider.of<DailyProductionData>(context, listen: false)
                        .addProductionList(addDailyProduct);
                    Navigator.of(context).pop();
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(100, 20, 100, 0),
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Center(
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
