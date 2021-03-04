import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qrscanner/models/scan_model.dart';
export 'package:qrscanner/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  //Creacion de la instancia de la clase
  static final DBProvider db = DBProvider._();
  //Constructor privado
  //De esta manera cuando se haga una nueva instancia
  // siempre se hara referencia a la misma
  DBProvider._();

  //Manera de acceder a la propiedad
  Future<Database> get database async {
    //Si ha sido instanciado anteriormente, que regrese la misma base de datos
    if (_database != null) return _database;

    //Metodo para inicializar la database en caso de que este null
    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    //Path donde se almacenara la db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //Union del path de documentsDirectory con el nombre la db
    final path = join(documentsDirectory.path, 'ScansDB.db');
    //print(documentsDirectory.path);
    print(path);

    //Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(''' 
      CREATE TABLE Scans(
        id INTEGER PRIMARY KEY,
        tipo TEXT,
        valor TEXT
      )
      ''');
    });
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    //Insert recibe como valores un mapa, igual al jason del modelo
    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);
    //Id del ultimo registro insertado
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodos() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  //Filtro para obtener el tipo de dato
  Future<List<ScanModel>> getScansByTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
    SELECT * FROM Scans WHERE tipo = '$tipo'
    
    
    ''');

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  //FUncion que regresa la cantidad registros borrados
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
    DELETE FROM Scans
    
    ''');

    return res;
  }
}
