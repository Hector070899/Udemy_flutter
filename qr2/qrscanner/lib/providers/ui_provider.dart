import 'package:flutter/material.dart';

//Manejador de estado: Provider
//Permite tener acceso a la informacino y redibujar los widgets
//Cuando sea requerido

//ChangeNotifier notifica a los widgets cuando cambia el estado de un widget
class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  //Getter para recuperar el valor de _selectedMenuOpt a traves de una prop publica
  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  //Setter para cambiar el valor de selectedMenuOpt a traves del valor de i
  set selectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    //Metodo para informar que cambio el valor de i
    notifyListeners();
  }
}
