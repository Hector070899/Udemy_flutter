void main() {
  //Toma el asignado asignado en el map, en este caso es true
  String propiedad = 'soltero';
  //Definir entre signos los tipos de valores que va a tener mapa
  //de otra forma van a ser a todos dinamicos
  Map<String, dynamic> persona = {
    'nombre': 'Hector',
    'edad': 21,
    'soltero': true
  };
  // print(persona['nombre']);
  // print(persona['edad']);
  // print(persona[propiedad]);

  Map<int, String> personas = {1: 'Hector', 2: 'Carlos', 3: 'Donald'};

  personas.addAll({4: 'America'});
  print(personas[2]);
}
