import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  
  static final nameDB = 'SOCIALDB';
  static final version = 1;

  static Database? _database;
  /*
  Future<Database>get database async{
    if(_database != null ) return _database!;
    _database = _initDatabase();
  }
  */
}