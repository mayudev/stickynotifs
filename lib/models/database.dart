import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stickynotifs/models/note.dart';

void initializeDatabase() async {}

/// Helper for Notes database
class NoteHelper {
  //static late Future<Database> database;
  static String table = 'notes';

  /// Create returns an opened database
  static Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), 'stickynotifs.db'),
        onCreate: ((db, version) => init(db)), version: 1);
  }

  static Future<void> init(Database database) async {
    await database.execute('''CREATE TABLE $table(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              content TEXT,
              createdAt INTEGER NOT NULL,
              updatedAt INTEGER NOT NULL,
              remindAt INTEGER
            );
            ''');
  }

  /// Insert new [Note] into database
  static Future<int> insertNote(Note note) async {
    final db = await database();

    final id = await db.insert(table, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  /// Return all [Note]s present in dtabase
  static Future<List<Note>> getNotes() async {
    final db = await database();

    final List<Map<String, dynamic>> raw = await db.query(table);

    // Generate a List
    List<Note> list = raw.map((element) => Note.fromMap(element)).toList();

    return list;
  }

  /// Updates a [Note]
  static Future<int> updateNote(int id, Note note) async {
    final db = await database();

    final result =
        await db.update(table, note.toMap(), where: "id = ?", whereArgs: [id]);

    return result;
  }

  /// Delete a [Note] by ID
  static Future<void> deleteNote(int id) async {
    final db = await database();

    await db.delete(table, where: "id = ?", whereArgs: [id]);
  }
}
