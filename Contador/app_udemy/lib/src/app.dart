import 'package:app_udemy/src/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'pages/contador_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    //Construye este material app que lanza ContadorPage
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContadorPage(),
    );
  }
}
