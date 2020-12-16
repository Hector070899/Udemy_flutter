import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;
  //El required indica que se tiene que mandar la lista
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    //Se utiliza mediaquery para determinar el tamano de la pantalla
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        //Definimos heigh y width a traves de screensize y los porcentajes
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.width * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              'https://www.agora-gallery.com/advice/wp-content/uploads/2015/10/image-placeholder.png',
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: peliculas.length,
        //pagination: SwiperPagination(),
        //control: SwiperControl(),
      ),
    );
  }
}
