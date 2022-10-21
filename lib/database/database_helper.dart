import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note_model.dart';

class DataBaseHelper {
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) {
      return _database;
    }

    _database = await initialDatabase();
    return _database;
  }

  initialDatabase() async {
    Directory dpath = await getApplicationDocumentsDirectory();

    String path = join(dpath.path, "note.db");
   return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE note(
      id INTEGER PRIMARY KEY,
      studentid TEXT,
      name TEXT,
      email TEXT,
      department TEXT,
      university TEXT,
      datetime TEXT
      
      )
      ''');
  }

  Future addNote(NoteModel noteModel) async {
    Database? database = await db;

    return await database!.insert("note", noteModel.toJson());
  }

  Future<List<NoteModel>?> getNoteModel() async {
    Database? database = await db;

    var data = await database!.query("note", orderBy: "id");

    List<NoteModel> noteModels =
        data.map((noteModel) => NoteModel.fromJson(noteModel)).toList();

    return noteModels;
  }
}
