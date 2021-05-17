import 'dart:async';
import 'dart:convert';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey = '11fdab2814ebdc25208505aa91b5ba6f';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  //manejo del stream, maneja un listado de peliculas
  List<Pelicula> _populares = [];
  //Se indica que informacion va a fluir dentro del stream, en este caso una lista de peliculas
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();
  //El broadcast permite que _popularesStram sea escuchado en muchos lugares

  //La funcion solo puede recibir una lista de Peliculas
  //Anade
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.add;

  //Escucha
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  //Metodo que se llama para cerrar el stream
  void dispose() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    //Decodificacion de resp, toma el string de la respuesta del json y lo transforma en un mapa
    final decodedData = json.decode(resp.body);
    //print(decodedData['results']);
    //El constructor se encarga de barrer cada uno de los resultados que esten en la lista
    //y generar las peliculas
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    //print(peliculas.items[0].title);
    return peliculas.items;
  }

  //Metodo de tipo future que regresa un listado de peliculas
  Future<List<Pelicula>> getEnCines() async {
    //Construccion del url para hacer la peticion http a traves de Uri
    final url = Uri.https(_url, '3/movie/now_playing',
        //Mapa string string, parametros del query
        {'api_key': _apikey, 'language': _language});
    //Retorna y almcacena toda la respuesta http
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    //Cada vez que se llama incrementa
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular',
        //Mapa string string, parametros del query
        {
          'api_key': _apikey,
          'language': _language,
          'page': _popularesPage.toString()
        });

    final resp = await _procesarRespuesta(url);
    //Anade un iterable que anade toda la respuesta
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    //Toma el body y lo transforma en un mapa
    final decodedData = json.decode(resp.body);
    //Se manda el mapa en su propiedad de cast
    final cast = Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }

  //Recibe como argumento la palabra para buscarla en el API
  Future<List<Pelicula>> buscarPeliculas(String query) async {
    //Construccion del url para hacer la peticion http a traves de Uri
    final url = Uri.https(_url, '3/search/movie', {
      //Mapa string string, parametros del query
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });
    //Retorna y almcacena toda la respuesta http
    return await _procesarRespuesta(url);
  }
}
