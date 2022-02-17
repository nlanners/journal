import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/journal_entry_dto.dart';

const SCHEMA_PATH = 'assets/schema_1.txt';

class DatabaseManager {

  static const String DATABASE_FILENAME = 'journal.sqlite3.db';
  static const String SQL_INSERT = 'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?);';
  static const String SQL_SELECT = 'SELECT * FROM journal_entries;';
  

  static late DatabaseManager _instance;

  final Database db;

  DatabaseManager._({required Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future<String> createSchema(path) async {
    return await rootBundle.loadString(path);
  }

  static Future initialize() async {
    final db = await openDatabase(
      DATABASE_FILENAME,
      version: 1,
      onCreate: (Database db, int version) async {
        createTables(db, await createSchema(SCHEMA_PATH));
        }
      );
      _instance = DatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry({required JournalEntryDTO dto}) {
    db.transaction( (txn) async {
      await txn.rawInsert(SQL_INSERT,
      [dto.title, dto.body, dto.rating, dto.dateTime.toString()]);
    });
  }

  Future<List<Map>> journalEntries() {
    return db.rawQuery(SQL_SELECT);
  }

  Future<bool> journalIsEmpty() async {
    List<Map> entries = await journalEntries();
    return entries.isEmpty;
  }
}