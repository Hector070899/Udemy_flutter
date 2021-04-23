//Recibe un string s
//si s esta vacio no es un numero == isempty
//n trata de parsear s si lo parsea es true si no es false

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}
