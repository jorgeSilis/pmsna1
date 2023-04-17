import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/event_model.dart';
import '../models/post_model.dart';

class DatabaseHelper {
  static final nameDB = 'SOCIALDB';
  static final versionDB = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    print(pathDB);
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async {
    String query = '''CREATE TABLE tblPost (
        idPost INTEGER PRIMARY KEY,
        descPost VARCHAR(200),
        datePost DATE
      );''';
    db.execute(query);
    query = '''
    CREATE TABLE tblFavorites (
      idFav INTEGER PRIMARY KEY,
      idMovie INTEGER UNIQUE
    );
    ''';
    db.execute(query);
    query = '''
    CREATE TABLE tblEvent (
      idEvent INTEGER PRIMARY KEY,
      title VARCHAR(50),
      dscEvent VARCHAR(200),
      initDate DATE,
      endDate DATE,
      status INTEGER
    );
    ''';
    db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.update(tblName, data,
        where: 'idPost = ?', whereArgs: [data['idPost']]);
  }

  Future<int> DELETE(String tblName, int idPost) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'idPost=?', whereArgs: [idPost]);
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  /*practica 5 */

  Future<int> BORRAR_FAV(int idMovie) async {
    var conexion = await database;
    return conexion
        .delete('tblFavorites', where: 'idMovie = ?', whereArgs: [idMovie]);
  }

  Future<bool> MARC_FAV(int idMovie) async {
    var conexion = await database;
    var result = await conexion.rawQuery(
        "SELECT EXISTS(SELECT 1 FROM tblFavorites WHERE idMovie=$idMovie) as result; ");
    Map<String, Object?> mapRead = result.first;
    return mapRead['result'] == 1;
  }

  /*eventos pratica atrasada */

  Future<List<Event>> GETALLEVENTS() async {
    var conexion = await database;
    var result = await conexion.query('tblEvent');
    return result.map((event) => Event.fromMap(event)).toList();
  }

  Future<int> UPDATE_EVENT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.update(tblName, data,
        where: 'idEvent = ?', whereArgs: [data['idEvent']]);
  }

  Future<int> DELETE_EVENT(String tblName, int idEvent) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'idEvent = ?', whereArgs: [idEvent]);
  }
}
