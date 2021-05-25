import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_provider/src/models/category_models.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _UrlNews = 'http://newsapi.org/v2';
final _APIKEY = '78bca3f8936a447599d2a902bd7f305e';

class NewsService with ChangeNotifier {
  //Lista de tipo Articles que proviene de news_models
  List<Article> headlines = [];

  String _selectedCategory = 'general';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.baseballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology')
  ];

  //Mapa que tiene como llave cada una de las categorias y apunta a una lista de categorias
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    //Se recorre el arreglo de las categorias para inicializarlo en el mapa y se guardan en una nueva lista
    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
  }

  get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    //Se establece el valor de la categoria
    _selectedCategory = valor;
    //Aqui se empieza a cargar y traer el valor dependiendo de la categoria
    getArticlesByCategory(valor);

    notifyListeners();
  }

  //Getter que recibe una lista de informacion de la categoria seleccionada
  List<Article> get getArticulosCategoriaSeleccionada {
    return categoryArticles[selectedCategory];
  }

  getTopHeadlines() async {
    final url = '$_UrlNews/top-headlines?apiKey=$_APIKEY&country=ca';
    final resp = await http.get(Uri.tryParse(url));
    //Obtener el body de la respuesta con el metodo FromJson que proviene del model
    final newsResponse = newsResponseFromJson(resp.body);
    //Se anaden todos los articulos en la lista de headlines
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  //Recibe la categoria para mostrar las noticias por categorias
  getArticlesByCategory(String category) async {
    //Validacion en caso de que ya este cargada la lista, se devuelve la misma lista
    if (categoryArticles[category].length > 0) {
      return categoryArticles[category];
    }
    //uso del argumento en el url
    final url =
        '$_UrlNews/top-headlines?apiKey=$_APIKEY&country=ca&category=$category';
    final resp = await http.get(Uri.tryParse(url));
    //Obtener toda la informacion referente de la categoria seleccionada
    final newsResponse = newsResponseFromJson(resp.body);
    //Aqui se insertan las noticias en la categoria seleccionada
    categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}
