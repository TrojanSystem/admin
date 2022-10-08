import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data_model/production_model.dart';

class ProductionModelDatabase {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'productionModelDatabase.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE productionModelDatabaseTable(id INTEGER PRIMARY KEY,bale_5 TEXT,bale_10 TEXT, slice TEXT, bombolino TEXT,bale_5_Sp TEXT,bale_10_Sp TEXT, slice_Sp TEXT,producedDate TEXT, bombolino_Sp TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(ProductionModel task) async {
    Database db = await database();
    int data = await db.insert('productionModelDatabaseTable', task.toMap());
    return data;
  }

  Future<List<ProductionModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('productionModelDatabaseTable');
    List<ProductionModel> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => ProductionModel.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(ProductionModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'productionModelDatabaseTable',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(String id) async {
    Database _db = await database();
    await _db
        .rawDelete("DELETE FROM productionModelDatabaseTable WHERE id = '$id'");
  }
}
