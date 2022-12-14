import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> production = [];
  final List<Map<String, dynamic>> databaseDataForShop = [];
  void loadProductionList() async {
    notifyListeners();
    await for (var x
        in FirebaseFirestore.instance.collection('LoggedUser').snapshots()) {
      for (var snap in x.docs) {
        notifyListeners();
        production.add(snap.data());
      }
    }
    notifyListeners();
  }

  void loadSoldList() async {
    notifyListeners();
    await for (var y
        in FirebaseFirestore.instance.collection('DailyShopSell').snapshots()) {
      for (var snapSell in y.docs) {
        notifyListeners();
        databaseDataForShop.add(snapSell.data());
      }
    }
    notifyListeners();
  }
}
