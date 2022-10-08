import 'package:ada_bread/dataHub/data_model/contract_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContractModelDatabase {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'contractModelDatabase.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE contractModelDatabaseTable(name TEXT,date TEXT, quantity TEXT, price TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(ContractModel task) async {
    Database db = await database();
    int data = await db.insert('contractModelDatabaseTable', task.toMap());
    return data;
  }

  Future<List<ContractModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('contractModelDatabaseTable');
    List<ContractModel> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => ContractModel.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(ContractModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'contractModelDatabaseTable',
      item.toMap(),
      where: 'name = ?',
      whereArgs: [item.name],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(String id) async {
    Database _db = await database();
    await _db
        .rawDelete("DELETE FROM contractModelDatabaseTable WHERE name = '$id'");
  }
}
