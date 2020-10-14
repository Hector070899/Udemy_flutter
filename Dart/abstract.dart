void main() {
  final perro = Perro();
  final gato = Gato();
  perro.emitirSonido();
  gato.emitirSonido();
}

abstract class Animal {
  int patas;

  void emitirSonido();
}

//La clase animal mediante el implements
//Obliga a la clase perro y gato a tener
//la variable patas y la funcion emitirSonido
class Perro implements Animal {
  int patas;
  int colas;

  void emitirSonido() => print('Guau');
}

class Gato implements Animal {
  int patas;
  int colas;
  void emitirSonido() => print('Miau');
}
