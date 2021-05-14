import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotificationsService {
  //Va a obtener la instancia de firebaseMessaging y lo relacionado al proyecto
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static StreamController<String> _messageStream = StreamController.broadcast();

  //De esta manera solo se expone el stream y van a escucharlo publicamente sin problemas
  static Stream<String> get messagesStream => _messageStream.stream;

  //Creacion Hanlders que van a escuchar y manejar las notificaciones

  //Recibe como parametro un dato de tipo RemoteMessage llamado message
  //Recibe cuando la app esta en el background
  static Future<void> _backgroundHandler(RemoteMessage message) async {
    //Imprimir el id del message
    print('on background Handler');

    //Cuando recibe una notificacion se anade al stream
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'no data');
  }

  //Recibir cuando la app esta abierta
  static Future<void> _onMessagedHandler(RemoteMessage message) async {
    print('on Message Handler ${message.messageId}');
    _messageStream.add(message.data['producto'] ?? 'no data');
  }

  //Recibir cuando la app esta cerrada
  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    print('on Message Open App Handler ${message.messageId}');
    _messageStream.add(message.data['producto'] ?? 'no data');
  }

  static Future initializeApp() async {
    //Push Notificactions
    await Firebase.initializeApp();
    //Obtencion del token con el que se pueden enviar notificaciones a este dispositivo
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //Implementacion Handlers solo se pasa como referencia a la funcion los handlers ya creados
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessagedHandler);
    FirebaseMessaging.onMessage.listen(_onMessageOpenApp);

    //Local Notifications
  }

  //Definir cerrar el stream
  static closeStreams() {
    _messageStream.close();
  }
}
