import 'package:ada_bread/dataHub/data_model/orderModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OrderModelDatabase {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'orderList.db'),
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE orderListTable(id INTEGER PRIMARY KEY, name TEXT,orderedKilo TEXT,pricePerKG TEXT,remain TEXT,phoneNumber TEXT,totalAmount TEXT,date TEXT)''');
      },
      version: 1,
    );
  }

  Future<int> insertTask(OrderModel task) async {
    Database db = await database();
    int data = await db.insert('orderListTable', task.toMap());
    return data;
  }

  Future<List<OrderModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('orderListTable');
    List<OrderModel> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => OrderModel.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(OrderModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'orderListTable',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM orderListTable WHERE id = '$id'");
  }
}
