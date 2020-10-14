void main() {
  final superman = Heroe();
  final luthor = Villano();

  superman.nombre = ('Clark Kent');
  luthor.nombre = ('Lex Luthor');
}

abstract class Personaje {
  String poder;
  String nombre;
}

//Se van a extender propiedades y metodos que tenga
//la clase heroe a todas las clases que extiendan de ella
class Heroe extends Personaje {
  bool valentia;
}

class Villano extends Personaje {
  bool maldad;
}
