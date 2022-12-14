import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProductionInput extends StatefulWidget {
  const ProductionInput({Key key}) : super(key: key);

  @override
  State<ProductionInput> createState() => _ProductionInputState();
}

class _ProductionInputState extends State<ProductionInput> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _bale_5_SP = TextEditingController();
  final TextEditingController _bale_10_SP = TextEditingController();
  final TextEditingController _slice_SP = TextEditingController();
  final TextEditingController _bombolino_SP = TextEditingController();
  final TextEditingController _bale_5 = TextEditingController();
  final TextEditingController _bale_10 = TextEditingController();
  final TextEditingController _slice = TextEditingController();
  final TextEditingController _bombolino = TextEditingController();
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
  void dispose() {
    _bale_5_SP.dispose();
    _bale_10_SP.dispose();
    _slice_SP.dispose();
    _bombolino_SP.dispose();
    _bale_5.dispose();
    _bale_10.dispose();
    _slice.dispose();
    _bombolino.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('???????????? ?????????'),
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
                          '?????? 5 ??????',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _bale_5,
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
                          '?????????',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _bale_5_SP,
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
                          '?????? 10 ??????',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _bale_10,
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
                          '?????????',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _bale_10_SP,
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
                          '????????????',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _slice,
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
                          '?????????',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _slice_SP,
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
                          '???????????????',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _bombolino,
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
                          '?????????',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _bombolino_SP,
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
                        width: 240,
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
                    FirebaseFirestore.instance.collection('DailySell').add({
                      'bale_5_Sp': bale_5_SP,
                      'bale_10_Sp': bale_10_SP,
                      'slice_Sp': slice_SP,
                      'bombolino_Sp': bombolino_SP,
                      'bale_5': bale_5,
                      'bale_10': bale_10,
                      'slice': slice,
                      'bombolino': bombolino,
                      'producedDate': dateTime
                    });
                    _bale_5.clear();
                    _bale_5_SP.clear();
                    _bale_10.clear();
                    _bale_10_SP.clear();
                    _slice.clear();
                    _slice_SP.clear();
                    _bombolino.clear();
                    _bombolino_SP.clear();
                    Fluttertoast.showToast(
                        msg: "Items Registered Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 18.0);
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
