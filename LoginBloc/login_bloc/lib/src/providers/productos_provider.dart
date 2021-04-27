import 'dart:convert';
import 'dart:io';
import 'package:login_bloc/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'package:login_bloc/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductosProvider {
  //Url del db de firebase
  final _url = 'https://flutter-varios-8283e-default-rtdb.firebaseio.com';
  final _prefs = PreferenciasUsuario();

  //Metodo que inserta los productos en firebase
  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    final resp =
        await http.post(Uri.parse(url), body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);
    print(decodedData);

    return true;

    // ?auth=${_prefs.token}
  }

  //Funcion que carga los productos desde firebase
  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';
    final resp = await http.get(Uri.parse(url));
    //Especificar el contenido del decodedData
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    //Lista que va a contener los datos barridos y que va a ser retornada
    final List<ProductoModel> productos = [];

    //Validacion para verificar que la resp no este vacio
    if (decodedData == null) return [];
    print("Este es el test $decodedData");
    //For each que recorre decodedData y regresa cada Map con con el id y el producto
    decodedData.forEach((id, producto) {
      print(producto);
      //Lista temporal que va a tener los productos barridos en el foreach
      final prodTemp = ProductoModel.fromJson(producto);
      //Como el id no viene en el producto, se iguala el id que viene como parte del mapa con
      //el del metodo fromJson
      prodTemp.id = id;

      productos.add(prodTemp);
    });
    // print(productos);

    return productos;
  }

  Future<int> borrarProductos(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(Uri.parse(url));

    print(resp.body);

    return 1;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';

    final resp =
        await http.put(Uri.parse(url), body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);
    print(url);
    print(resp.request);

    return true;
  }

  //Funcino que retorna el secure_url
  ////Recibe como argumento la imagen
  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dzf6lcihe/image/upload?upload_preset=zluzarfe');

    //Obtener el tipo de file a traves del path usando el paquete mime_type
    //Separa el path por medio de split
    //para obtener en la primera posicion la imagen y en la segunda la extension
    final mimeType = mime(imagen.path).split('/');
    //Request para adjuntar la imagen
    final imageUploadRequest = http.MultipartRequest('POST', url);

    //Archivo local a adjuntar
    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      //El content son las dos partes del mimeType
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    //Se adjuntan los archivos
    imageUploadRequest.files.add(file);

    //Se ejecuta la peticion
    final streamRespone = await imageUploadRequest.send();
    //Se obtiene la respueta y se guarda aca
    final resp = await http.Response.fromStream(streamRespone);

    //Verificar que la conexion fue exitosa
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Error de conexion');
      print(resp.body);
      return null;
    }
    //Se extrae yse devuelve  el secure_url de la resp
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
