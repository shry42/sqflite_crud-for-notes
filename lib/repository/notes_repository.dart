import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_crud/models/notes.dart';

class NotesRepository {
  static const _dbName = 'notes_database.db';
  static const _tableName = 'notes';

  static Future<Database?> _database() async {
    final database = openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdAt TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  static insert({required Note note}) async {
    final db = await _database();
    await db?.insert(
      _tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Note>> getNotes() async {
    final db = await _database();

    final List<Map<String, dynamic>> maps = await db!.query(_tableName);

    // Convert the List<Map<String,dynamic> into a List<notes>

    return List.generate(maps.length, (i) {
      return Note(
          id: maps[i]['id'] as int,
          title: maps[i]['title'] as String,
          description: maps[i]['description'] as String,
          createdAt: DateTime.parse(maps[i]['createdAt']));
    });
  }

  static update({required Note note}) async {
    final db = await _database();

    //Update the given table
    await db?.update(
      _tableName,
      note.toMap(),
      //Ensure the tablename has the matching id,
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static delete({required Note note}) async {
    final db = await _database();

    //Update the given table
    await db?.delete(
      _tableName,
      //Ensure the tablename has the matching id,
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
