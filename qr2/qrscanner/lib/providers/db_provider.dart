import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  //Creacion de la instancia de la clase
  static final DBProvider db = DBProvider._();
  //Constructor privado
  //De esta manera cuando se haga una nueva instancia
  // siempre se hara referencia a la misa
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
}
