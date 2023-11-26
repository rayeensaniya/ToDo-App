import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "database.db";
  static const _databaseVersion = 1;
  static const table = "ToDo";
  static const columnId = '_id';
  static const columnTittle = "tittle";
  static const columnDescription = "description";
  static const dueDate = "due_date";
  static const status = 'status';
  static const createdAt = 'created_at';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  /// CHECKING DATABASE IS NULL OR NOT
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  /// INITIALIZING DATABASE
  Future<Database> initDatabase() async {
    // Getting path of document folder of android app
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Creating database column in the path
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  /// CREATING TABLE
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTittle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $dueDate TEXT NOT NULL, 
            $status TEXT NOT NULL, 
            $createdAt TEXT NOT NULL  
          )
          ''');
  }

  /// INSERTING TO DATABASE
  Future<int> insert(Map<String, dynamic> data) async {
    Database db = await instance.database;
    return await db.insert(table, data);
  }

  Future<int> update({required int id, Map<String, dynamic>? data}) async {
    Database db = await instance.database;
    return await db.update(table, data!,
        where: '${DatabaseHelper.columnId}= ?', whereArgs: [id]);
  }

  /// QUERYING OR FETCHING FROM DATABASE
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    /// Fetching all todo notes frm databse
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(table, where: '${DatabaseHelper.columnId}= ?', whereArgs: [id]);
  }
}
