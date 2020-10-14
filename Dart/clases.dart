import 'dart:convert';

void main() {
  // final wolverine = Heroe(nombre: 'Logan', poder: 'Regeneracion');
  final rawJson = '{"nombre": "Logan","poder":"Regeneracion"}'; //Direccion json
  Map parsedJson = json.decode(rawJson); //Extraer datos de json
  final wolverine = Heroe.fromJson(parsedJson);

  print(wolverine.nombre);
  print(wolverine.poder);
}

class Heroe {
  String nombre;
  String poder;

  Heroe({this.nombre, this.poder});
  //Constructor con nombre para extraer
  // del mapa que deuelve json las llaves
  Heroe.fromJson(Map parsedJson) {
    nombre = parsedJson['nombre'];
    poder = parsedJson['poder'];
  }

//   // @override
//   String toString() => 'nombre: $nombre - poder: $poder';
// }
}
