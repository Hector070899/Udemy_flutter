abstract class Animal {}

abstract class Mamifero extends Animal {}

abstract class Ave extends Animal {}

abstract class Peces extends Animal {}

abstract class Volador {
  void volar() => print("Estoy volando");
}

abstract class Caminante {
  void caminar() => print("Estoy Caminando");
}

abstract class Nadador {
  void nadar() => print("Estoy nadando");
}

class Delfin extends Mamifero with Nadador {}

class Murcielago extends Mamifero with Volador, Caminante {}

class Gato extends Mamifero with Caminante {}

class Pato extends Ave with Nadador, Caminante, Volador {}

class Tiburon extends Peces with Nadador {}

class PezVolador extends Peces with Nadador, Volador {}

void main() {
  final pato = Pato();
  pato.volar();
  final pezVolador = PezVolador();
  pezVolador.nadar();
}
