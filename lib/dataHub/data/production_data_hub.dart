import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductionModelData extends ChangeNotifier {
  //ContractModelDatabase contractModelDB = ContractModelDatabase();
  int taskDone = 0;
  int totalTask = 0;
  int bale_5 = 0;
  int bale_10 = 0;
  int slice = 0;
  int bombolino = 0;
  bool _isLoading = true;
  final List<Map<String, dynamic>> _contractList = [];

  List<Map<String, dynamic>> get contractList => _contractList;

  bool get isLoading => _isLoading;
  void loadContratList() async {
    notifyListeners();
    await for (var x
        in FirebaseFirestore.instance.collection('ContratGiven').snapshots()) {
      for (var snap in x.docs) {
        notifyListeners();
        _contractList.add(snap.data());
      }
    }
    notifyListeners();
  }

  //
  // bool get isLoading => _isLoading;
  //
  // Future loadContractList() async {
  //   _isLoading = true;
  //   notifyListeners();
  //   _contractList = await contractModelDB.getTasks();
  //   _isLoading = false;
  //   notifyListeners();
  // }
  //
  // Future addContractList(ContractModel task) async {
  //   await contractModelDB.insertTask(task);
  //   await loadContractList();
  //   notifyListeners();
  // }
  //
  // Future updateContractList(ContractModel task) async {
  //   await contractModelDB.updateTaskList(task);
  //   await loadContractList();
  //   notifyListeners();
  // }
  //
  // Future deleteContractList(String task) async {
  //   await contractModelDB.deleteTask(task);
  //   await loadContractList();
  //   notifyListeners();
  // }

  String percent() {
    double x = 0;
    if (totalTask == 0) {
      x = (taskDone / 1);
    } else {
      x = (taskDone / totalTask);
    }

    if (x < 1) {
      return x.toStringAsFixed(2);
    } else {
      return 1.0.toString();
    }
  }

  String totalProduced() {
    int x = 0;
    if (bale_5 == 0 && bale_10 == 0 && slice == 0 && bombolino == 0) {
      x = 0;
      return x.toString();
    } else {
      x = (bale_5 + bale_10 + slice + bombolino);
      return x.toString();
    }
  }

  int doublePercent() {
    double x = 0;
    if (totalTask == 0) {
      x = (taskDone * 0 / 1);
    } else {
      x = (taskDone * 100 / totalTask);
    }

    return x.floor();
  }

  List daysOfMonth = [
    {
      'mon': 'Day 1',
      'day': 1,
    },
    {
      'mon': 'Day 2',
      'day': 2,
    },
    {
      'mon': 'Day 3',
      'day': 3,
    },
    {
      'mon': 'Day 4',
      'day': 4,
    },
    {
      'mon': 'Day 5',
      'day': 5,
    },
    {
      'mon': 'Day 6',
      'day': 6,
    },
    {
      'mon': 'Day 7',
      'day': 7,
    },
    {
      'mon': 'Day 8',
      'day': 8,
    },
    {
      'mon': 'Day 9',
      'day': 9,
    },
    {
      'mon': 'Day 10',
      'day': 10,
    },
    {
      'mon': 'Day 11',
      'day': 11,
    },
    {
      'mon': 'Day 12',
      'day': 12,
    },
    {
      'mon': 'Day 13',
      'day': 13,
    },
    {
      'mon': 'Day 14',
      'day': 14,
    },
    {
      'mon': 'Day 15',
      'day': 15,
    },
    {
      'mon': 'Day 16',
      'day': 16,
    },
    {
      'mon': 'Day 17',
      'day': 17,
    },
    {
      'mon': 'Day 18',
      'day': 18,
    },
    {
      'mon': 'Day 19',
      'day': 19,
    },
    {
      'mon': 'Day 20',
      'day': 20,
    },
    {
      'mon': 'Day 21',
      'day': 21,
    },
    {
      'mon': 'Day 22',
      'day': 22,
    },
    {
      'mon': 'Day 23',
      'day': 23,
    },
    {
      'mon': 'Day 24',
      'day': 24,
    },
    {
      'mon': 'Day 25',
      'day': 25,
    },
    {
      'mon': 'Day 26',
      'day': 26,
    },
    {
      'mon': 'Day 27',
      'day': 27,
    },
    {
      'mon': 'Day 28',
      'day': 28,
    },
    {
      'mon': 'Day 29',
      'day': 29,
    },
    {
      'mon': 'Day 30',
      'day': 30,
    },
    {
      'mon': 'Day 31',
      'day': 31,
    },
  ];

  List monthOfAYear = [
    {
      'mon': 'Jan',
      'day': 1,
    },
    {
      'mon': 'Feb',
      'day': 2,
    },
    {
      'mon': 'Mar',
      'day': 3,
    },
    {
      'mon': 'Apr',
      'day': 4,
    },
    {
      'mon': 'May',
      'day': 5,
    },
    {
      'mon': 'Jun',
      'day': 6,
    },
    {
      'mon': 'Jul',
      'day': 7,
    },
    {
      'mon': 'Aug',
      'day': 8,
    },
    {
      'mon': 'Sept',
      'day': 9,
    },
    {
      'mon': 'Oct',
      'day': 10,
    },
    {
      'mon': 'Nov',
      'day': 11,
    },
    {
      'mon': 'Dec',
      'day': 12,
    },
  ];
}
