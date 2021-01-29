//Instancia de Actor que mapea toda la lista de actores que recibe del Json
//
class Cast {
  List<Actor> actores = List();

  //Constructor que recibe la lista del cast y recorre la lista de actores
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      //instancia de actor que seran agregados a la lista
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

//Objeto de actor

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  String name;
  int order;
  String profilePath;

  Actor(
      {this.castId,
      this.character,
      this.creditId,
      this.gender,
      this.name,
      this.order,
      this.profilePath});

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  //Metodo para extraer la foto
  getPhoto() {
    if (profilePath == null) {
      return 'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-illustration-132483587.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
