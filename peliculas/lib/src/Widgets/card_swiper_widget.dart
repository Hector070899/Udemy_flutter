import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;
  //El required indica que se tiene que mandar la lista de tarjetas(peliculas)
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    //Se utiliza mediaquery para determinar el tamano de la pantalla
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        layout: SwiperLayout.STACK,
        //Definimos heigh y width a traves de screensize y los porcentajes
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.width * 0.9,
        itemBuilder: (BuildContext context, int index) {
          //Establece como id el valor del Id con la concatenacion de tarjeta para
          //hacerlo unico y pasarselo al tag de Hero
          peliculas[index].unqiueId = '${peliculas[index].id}-tarjeta';

          return Hero(
            tag: peliculas[index].unqiueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalle',
                    arguments: peliculas[index]),
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/loading.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
      ),
    );
  }
}
