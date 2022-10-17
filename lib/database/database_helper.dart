import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo_model.dart';

class DbHelper {
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database;
  }

  String TABLE_NAME = "todos.db";

  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, TABLE_NAME);
    return openDatabase(path, version: 1, onCreate: _onCreate);

  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todos 
    (  
    id INTEGER PRIMARY KEY,
    title TEXT,
    description TEXT,
    dateTime TEXT
    
    )
   
    ''');
  }

  Future addTodo(TodoModel todoModel) async {
    Database? database = await db;
    return await database!.insert('todos', todoModel.toJson());
  }

  Future<List<TodoModel>?> getTodoModel() async {
    Database? database = await db;
    var data = await database!.query("todos", orderBy: "id");

    List<TodoModel> todoModels =
        data.map((todoModel) => TodoModel.fromJson(todoModel)).toList();

    return todoModels;
  }
}
