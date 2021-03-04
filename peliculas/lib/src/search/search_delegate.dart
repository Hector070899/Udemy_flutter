//Clase que tiene que cumplir ciertas condiciones

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final seleccion = ' ';
  final peliculasProvider = PeliculasProvider();
  final peliculas = [
    'Hellboy',
    'La huerfana',
    'Iron Man',
    'Batman',
    'Superman'
  ];
  final peliculasRecientes = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    //Las acciones de el AppBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            //de esta forma se borra el texto del appBar
            //presionando el icono clear
            query = ' ';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          //metodo del search_delegate para cerrar la busqueda
          close(context, null);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Builder que crea las sugerencias que aparecen cuando la persona escribe

    //Lista que indica: si el query esta vacio retorna las recientes
    //de otra forma retorna la condicion
    // final listaSugerida = (query.isEmpty)
    //     ? peliculasRecientes
    //     : peliculas
    //         .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
    //         .toList();

    // return ListView.builder(
    //   //Recibe la lista sugerida
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //         leading: Icon(Icons.movie),
    //         title: Text(
    //           listaSugerida[i],
    //         ),
    //         onTap: () {});
    //   },
    // );

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: peliculasProvider.buscarPeliculas(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            return ListView(
                //convertir la lista de peliculas en una lista de Widgets
                children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/loading.gif'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  //primero se cierra la busqueda
                  close(context, null);
                  //el tag de hero no puede estar en null
                  pelicula.unqiueId = '';
                  //Navigator para cambiar a detalle
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }
}
