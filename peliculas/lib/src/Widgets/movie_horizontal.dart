import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

//Esta clase retorna un widget que muestra en paginas flotantes las peliculas populares
class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  //Funcion de callback que se manda a HomePage como referencia
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    //Obtener la posicion de pixeles del PageController para concer cuando
    //llega al final
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      //%20 del tamano de la pantalla
      height: _screenSize.height * 0.2,
      //Widget que sirve para ver paginas flotantes
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),

        //Metodo que regresa una lista de widgets
        //children: _tarjetas(context),
      ),
    );
  }

  //Necesita la pelicula y el buildcontext
  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    //Establece  como id el valor del Id con la concatenacion de poster para
    //hacerlo unico y pasarselo al tag de Hero
    pelicula.unqiueId = '${pelicula.id}-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 135.0,
              ),
            ),
            tag: pelicula.unqiueId,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        print('Id de pelicula: ${pelicula.id}');
      },
      child: tarjeta,
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 13.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 135.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
