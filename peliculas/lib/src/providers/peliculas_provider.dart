import 'dart:convert';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey = '11fdab2814ebdc25208505aa91b5ba6f';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

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
    final url = Uri.https(_url, '3/movie/popular',
        //Mapa string string, parametros del query
        {'api_key': _apikey, 'language': _language});
    //Retorna y almcacena toda la respuesta http
    return await _procesarRespuesta(url);
  }
}
