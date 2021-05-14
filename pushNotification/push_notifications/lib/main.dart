import 'package:flutter/material.dart';
import 'package:push_notifications/screens/home_screen.dart';
import 'package:push_notifications/screens/message_screen.dart';
import 'package:push_notifications/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Referencia por el cual el material app puede acceder a navigator y al scaffold
  //cuando se termine de constuir el widget
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerkey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    //Acceso al context
    PushNotificationsService.messagesStream.listen((message) async {
      // print('My App $message');

      await navigatorKey.currentState!.pushNamed('message', arguments: message);

      final SnackBar snackBar = SnackBar(content: Text(message));
      messengerkey.currentState!.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        //Navegar
        navigatorKey: navigatorKey,
        //Snacks
        scaffoldMessengerKey: messengerkey,
        routes: {
          'home': (_) => HomeScreen(),
          'message': (_) => MessageScreen(),
        });
  }
}
