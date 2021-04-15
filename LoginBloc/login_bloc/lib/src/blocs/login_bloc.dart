import 'dart:async';
import 'package:login_bloc/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

//Uso de mixing
class LoginBloc with Validators {
  //Cada vez que se teclee algo en el email va a pasar por el _emailController
  //Rxdart no trabaja con streamcontrollers, trabaja con BehaviorSubject
  //No es necesario especificar el broadcast
  //final _emailController = StremController<String>.broadcast();
  //final _passwordController = StremController<String>.broadcast();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del stream
  //Especificar que salen streams de tipo de strings
  //Uso de stream transformers para validacion de datos
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      //Ambos tienen que ser true para emitir que se cumplen las condiciones
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Insertar valores al stream
  //No es ejecuta solo se manda como referencia
  //Se especifica que es una funcion que solo recibes strings
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener el ultimo valor ingresado a los Streams a traves de getters
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    //Se usa ? para notificar que si es nulo no se ejecute y no se de un error
    _emailController?.close();
    _passwordController?.close();
  }
}
