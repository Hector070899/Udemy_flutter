import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  //Patron Singletone para ayudar a manejar instancia unica
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  //Permite tenerla almacenado para consumirla despues
  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //GET Y SET
  get genero {
    //Si no existe el genero el valor es 1
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }

  //GET Y SET
  get colorSecundario {
    //Si no existe el color regresa false
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('colorSecundario', value);
  }

  //GET Y SET
  get nombreUsuario {
    //Si no existe el nombre regresa un caracter vacio
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
  }

  //GET Y SET ultima pagina
  get ultimaPagina {
    //Si no existe el nombre regresa un caracter vacio
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
