import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/tabs_page.dart';
import 'package:news_provider/src/services/news_service.dart';
import 'package:news_provider/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //llamado del NewsService al Provider en el widget mas alto
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: TabsPage(),
      ),
    );
  }
}
