import 'dart:async';

class Validators {
  //Validacion de email
  final validarEmail =
      //Siempre es conveniente reflejar el tipo del StreamTransformer
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    //Expresion regular
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });

  //Validacion de password
  //Se especifica que informacion fluye y que informacion sale del StreamTransformer con <String,String>
  //handle data recibe el valor y el evento a realizar
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Mas de 6 caracteres por favor');
    }
  });
}
