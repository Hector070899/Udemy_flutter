void main() {
  final cuadrado = Cuadrado();
  cuadrado.lado = 10;
  print(cuadrado);
  print('area: ${cuadrado.area}');
}

class Cuadrado {
  double _lado;
  double _area;
  //Setter
  set lado(double valor) {
    if (valor <= 0) {
      throw ('El lado no puede ser menor o igual a 0');
    } //Es lo mismo que poner un else
    _lado = valor;
  }

  //Getter
  double get area => _lado * _lado;

  toString() => 'Lado: $_lado';
}
