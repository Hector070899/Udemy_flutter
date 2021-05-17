//Clase que contiene todas las peliculas
// que se estan manejando
class Peliculas {
  //lista de tipo pelicula que va a contener todas las peliculas mapeadas
  //por el for
  List<Pelicula> items = [];
  Peliculas(this.items);
  //Recibe el mapa de todas las peliculas y las transforma a items.
  //Cada item es una pelicula
  Peliculas.fromJsonList(List<dynamic> jsonList) {
    //Si el json list esta vacio no funciona
    if (jsonList == null) return;
    for (var item in jsonList) {
      //Se manda todo el item al constructor JsonMap
      final pelicula = Pelicula.fromJsonMap(item);
      //La nueva instancia de pelicula se almacena aca
      items.add(pelicula);
    }
  }
}

class Pelicula {
  //Creacion de variable id unico para evitar conflicto de id compartido con tags
  String unqiueId;
  double voteAverage;
  double popularity;
  int voteCount;
  String releaseDate;
  String title;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  String overview;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  int id;
  bool video;

  //Constructor
  Pelicula({
    this.voteAverage,
    this.popularity,
    this.voteCount,
    this.releaseDate,
    this.title,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.overview,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.id,
    this.video,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    //Para transformarlo a double
    voteAverage = json['vote_average'] / 1;
    popularity = json['popularity'] / 1;
    voteCount = json['vote_count'];
    releaseDate = json['release_date'];
    title = json['title'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    //Para convertirlo a entero
    genreIds = json['genre_ids'].cast<int>();
    overview = json['overview'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    id = json['id'];
    video = json['video'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-illustration-132483587.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackdropImg() {
    if (posterPath == null) {
      return 'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-illustration-132483587.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}

enum OriginalLanguage { EN, FR, KO, JA }
