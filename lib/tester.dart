import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_provider.dart';

class Tester extends StatelessWidget {
  const Tester({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DataProvider>(context).databaseDataForShop;
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('LoggedUser').snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
              );
            }
            final productionData = snap.data.docs;
            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                return Text(
                  '${user[index]['bale_5']}',
                  style: TextStyle(),
                );
              },
            );
          }),
    );
  }
}
