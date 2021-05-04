import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:login_bloc/src/models/producto_model.dart';
import 'package:login_bloc/src/providers/productos_provider.dart';

//Clase de productos que maneja a traves de Bloc
class ProductosBloc {
  //Stream que maneja la lista de productos
  final _productosController = BehaviorSubject<List<ProductoModel>>();
  //Stream para manejar la carga de productos
  final _cargandoController = BehaviorSubject<bool>();

  //Instancia de ProductosProvider
  final _productosProvider = ProductosProvider();

  //Escuchar streams, retorna un stream de lista de productoModel
  Stream<List<ProductoModel>> get productosStream =>
      _productosController.stream;

  Stream<bool> get cargandoStream => _cargandoController.stream;

  //Implementacion de CRUD para manejar con streams

  void cargarProductos() async {
    final productos = await _productosProvider.cargarProductos();
    _productosController.sink.add(productos);
    print(productos);
  }

  void agregarProductos(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  void editarProductos(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.editarProducto(producto);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto(File foto) async {
    _cargandoController.sink.add(true);
    final fotoUrl = await _productosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;
  }

  void borrarProductos(String id) async {
    _cargandoController.sink.add(true);
    await _productosProvider.borrarProductos(id);
    _cargandoController.sink.add(false);
  }

  //Cerrar controladores
  dispose() {
    _productosController?.close();
    _cargandoController?.close();
  }
}
