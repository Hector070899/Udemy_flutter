import 'package:flutter/material.dart';
import 'package:news_provider/src/services/news_service.dart';
import 'package:news_provider/src/widgets/lista_news.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

//Para mantener el estado del widget se mezcla con el mixin de keelAlive
class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    //Instancia de Provider de NewsService que extrae los headlines
    final headlines = Provider.of<NewsService>(context).headlines;
    // newsService.headlines;

    return Scaffold(
        //Condicion para cuando este cargando el contendido de los headlines
        body: (headlines.length == 0)
            ? Center(child: CircularProgressIndicator())
            : ListaNoticias(headlines));
  }

  //Se mantiene en true para mantener el estado
  @override
  bool get wantKeepAlive => true;
}
