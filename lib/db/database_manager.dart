import 'package:sqflite/sqflite.dart';
import '../models/journal_entry.dart';

class DatabaseManager {

  static const String DATABASE_FILENAME;//TODO: add filename;
  static const String SQL_CREATE_SCHEMA;
  static const String SQL_INSERT;
  static const String SQL_SELECT = 'SELECT * FROM journal_entries';

  static DatabaseManager? _instance;

  final Database db;

  DatabaseManager._({required Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    final db = await openDatabase(
      DATABASE_FILENAME,
      version: 1,
      onCreate: (Database db, int version) async {
        createTables(db, SQL_CREATE_SCHEMA);
        }
      );
      _instance = DatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry({JournalEntryDTO dto}) async {
    await db.transaction( (txn) async {
      await txn.rawInsert(SQL_INSERT,
      [dto.title, dto.body, dto.rating, dto.dateTime.toString()]);
    });
  }

  Future<List<Map>> journalEntries() {
    return db.rawQuery(SQL_SELECT);
  }
}