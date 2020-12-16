import 'package:flutter/material.dart';
import 'package:peliculas/src/Widgets/card_swiper_widget.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      //Safe area es un widget que coloca las cosas en lugares donde se pueden colocar
      body: Container(
        child: Column(
          children: <Widget>[
            _swipearTarjetas(),
          ],
        ),
      ),
    );
  }

  Widget _swipearTarjetas() {
    final peliculasProvider = PeliculasProvider();
    //Implementacion de metodo getEnCines
    peliculasProvider.getEnCines();
    return CardSwiper(peliculas: [1, 2, 3, 4, 5]);
  }
}
