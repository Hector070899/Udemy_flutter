import 'dart:convert';

//Funcion que recibe un json en forma de string y regresa una nueva instancia del modelo
ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

//Toma el modelo y lo genera a un json, pasandole por el json.encode
String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  ProductoModel({
    this.id,
    this.titulo = '',
    this.valor = 0.0,
    this.disponible = true,
    this.fotoURl,
  });

  String id;
  String titulo;
  double valor;
  bool disponible;
  String fotoURl;

  //Regresa una nueva instancia cuando se llame ese metodo
  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        titulo: json["titulo"],
        valor: json["valor"],
        disponible: json["disponible"],
        fotoURl: json["fotoURl"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "titulo": titulo,
        "valor": valor,
        "disponible": disponible,
        "fotoURl": fotoURl,
      };
}
