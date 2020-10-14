void main() {
  print('Estamos a punto de pedir datos');
  httpGet('http://api.nada.com/aliens').then((data) {
    print(data);
  });

  print('Ultima linea');
}

//Funcion de tipo Future que retorna String
Future<String> httpGet(String url) {
  //Argumento que esta siendo enviado
  //al constructor delayed
  //Duration recibe el argumento del tiempo de duracion
  return Future.delayed(Duration(seconds: 4), () {
    return 'Hola Mundo';
  });
}
