void main() {
  String mensaje = saludar(nombre: 'Hector', texto: 'Hola');
  print(mensaje);
}

String saludar({String texto, String nombre}) {
  // print('Hola');
  return '$texto $nombre';
}

//Arrow function que representa lo mismo que saludar
String saludar2({String texto, String nombre}) => '$texto $nombre';
