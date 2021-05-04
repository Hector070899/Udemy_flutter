import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/models/producto_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.productoBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        //un comentario
      ),
      body: _crearLista(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearLista(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final totalprod = snapshot.data;
          return ListView.builder(
            itemCount: totalprod.length,
            itemBuilder: (context, i) =>
                _crearItem(context, totalprod[i], productosBloc),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      child: Icon(Icons.add),
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto,
      ProductosBloc productosBloc) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) => productosBloc.borrarProductos(producto.id),
        child: Card(
          child: Column(
            children: <Widget>[
              (producto.fotoURl == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(producto.fotoURl),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text(
                    'Nombre: ${producto.titulo} - Precio: ${producto.valor}'),
                subtitle: Text(producto.id),
                onTap: () => Navigator.pushNamed(context, 'producto',
                    arguments: producto),
              ),
            ],
          ),
        ));
  }
}
