import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_scan_new/models/scan_model.dart';
export 'package:qr_scan_new/models/scan_model.dart';

// Path Provider y SQFLite
//Utilizando el patron Singleton
class DBProvider{

  static Database _database;
  //Constructor privado
  static final DBProvider db = DBProvider._();

  DBProvider._();

  //La respuesta de la BD puede suceder en cualquier instante
  Future<Database> get database async {
    if(_database!=null){
      return _database;
    }
    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    //Donde esta la BD
    Directory documentsDir = await getApplicationDocumentsDirectory();
    final path = join(documentsDir.path,'ScansDB.db');
    print('path> : $path');

    //Crear una BD
    //Version, aumentar con cada cambio estructural
    return await openDatabase(
      path,
      version: 1,
      onOpen:(db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        );
        ''');
      }
      );

  }

  //CREATE/Insert de forma completa
  nuevoScanRaw(ScanModel nuevoScan) async {
    
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final db = await database;//get

    final sql = '''
    INSERT INTO Scans( id, tipo, valor) 
    VALUES( $id, '$tipo', '$valor');
    ''';

    final res = await db.rawInsert(sql);

    return res;
  }

  //CREATE/Insert de forma simple, utiliza un mapa.
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;//Es el ID
  }

  Future<ScanModel> getScanbyId(int index) async {
    final db = await database;
    //query puede retornar mas de 1 elemento
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [index]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first): null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    //query puede retornar mas de 1 elemento
    final res = await db.query('Scans');

    return res.isNotEmpty 
    ? res.map(
      (e) => ScanModel.fromJson(e)
      ).toList()
    : [];
  }

  Future<List<ScanModel>> getScansForTypes(String type) async {
    final db = await database;
    //query puede retornar mas de 1 elemento
    final res = await db.rawQuery(
      '''
      SELECT * FROM Scans WHERE tipo = '$type'
      '''
    );

    return res.isNotEmpty 
    ? res.map(
      (e) => ScanModel.fromJson(e)
      ).toList()
    : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update(
      'Scans', 
      newScan.toJson(),
      where: 'id = ?',
      whereArgs: [newScan.id]
    );

    return res;
  }

  Future<int> deleteScan(int index) async {
    final db = await database;
    final res = await db.delete(
      'Scans',
      where: 'id = ?',
      whereArgs: [index]
    );
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete(
      '''
      DELETE FROM Scans
      '''
    );
    return res;
  }
}