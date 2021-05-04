import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/login_bloc.dart';
import 'package:login_bloc/src/blocs/productos_bloc.dart';
export 'package:login_bloc/src/blocs/productos_bloc.dart';
//Se exporta para que donde sea que se utilice el provider
//sea implicito el uso de loginBloc
export 'package:login_bloc/src/blocs/login_bloc.dart';

//Inherited widget pide que se haga una sobreescritura de updateShouldNotify
//que es una funcion que se encarga de notificar a todos los hijos cuando sea necesario
//osea cuando se de un cambio

class Provider extends InheritedWidget {
  //Instancia de la clase para mantener el estado del form
  ////Creacion de la instancia que se va a manejar de loginBloc
  final loginBloc = LoginBloc();
  final _productosBloc = ProductosBloc();

  static Provider _instancia;

  //La 1ra vez recibe informacion, la segund vez la utiliza
  //Determina si necesita regresar una nueva intancia
  //o utilizar la existente
  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      //Se crea un constructor privado para prevenir que
      //la clase sea incializada desde afuera
      _instancia = Provider._internal(key: key, child: child);
    }

    return _instancia;
  }

  //Key es un identificador unico del widget
  //child es una prop obligatoria
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  //Funcion que busca internamente en el arbol de widgets del context al provider
  // y va a retornar la instancia de loginBloc
  static LoginBloc of(BuildContext context) {
    //Busca en el contexto la instanica del provider que esta definido
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  //productosBloc es una nueva propiedad publica
  static ProductosBloc productoBloc(BuildContext context) {
    //Busca en el contexto la instanica del provider que esta definido
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        ._productosBloc;
  }
}
