import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();

      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'Muka.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 4, onUpgrade: _onUpgrade);

    return mydb;
  }

  _onUpgrade(Database db, int Oldversion, int NewVersion) async {
    print("=========Update DataBase");
    await db.execute("Alter table Notes add column color text");
  }

  _onCreate(Database db, int version) async {
    Batch bacch = db.batch();
    bacch.execute('''
    CREATE TABLE "Notes" (
      "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT ,
"title" text not null,
      "note" TEXT NOT NULL,
      "fav" integer not null,
      "date" text not null
    )
    ''');
    await bacch.commit();
    print("============Create db");
  }

  readData(String sql) async {
    Database? mydb = await db;
    // print(mydb);
    List<Map> response = await mydb!.rawQuery(sql);

    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    // print(db);
    int response = await mydb!.rawInsert(sql);

    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeletDataBase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'Muka.db');
    await deleteDatabase(path);
  }
}
