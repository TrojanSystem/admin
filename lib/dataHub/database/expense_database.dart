import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data_model/expense_model.dart';

class DatabaseExpense {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'expenseDatabase.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE expenseTable(id INTEGER PRIMARY KEY, itemName TEXT,total TEXT, itemPrice TEXT, itemDate TEXT, itemQuantity TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(ExpenseModel task) async {
    Database db = await database();
    int data = await db.insert('expenseTable', task.toMap());
    return data;
  }

  Future<List<ExpenseModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('expenseTable');
    List<ExpenseModel> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => ExpenseModel.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(ExpenseModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'expenseTable',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM expenseTable WHERE id = '$id'");
  }
}
