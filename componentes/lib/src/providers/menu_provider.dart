import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

//Expone un objeto(rootBundle)
//Con esta clase se puede tener disponible el json para la aplicacion
class _MenuProvider {
  List<dynamic> opciones = [];

  _MenuProvider();
  //Una funcion async retorna un future
  Future<List<dynamic>> cargarData() async {
    //Path de donde esta el json almacenado en un final resp
    final resp = await rootBundle.loadString('data/menu_opts.json');
    //Transformacion de json a mapa a traves de decode
    Map dataMap = json.decode(resp);
    //Opciones va a ser igual a la llave rutas dentro del mapa
    opciones = dataMap['rutas'];

    return opciones;
  }
}

//Crea instancia la clase privada _MenuProvider
//Asi solo expone la instancia creada y no todo el archivo
final menuProvider = _MenuProvider();
