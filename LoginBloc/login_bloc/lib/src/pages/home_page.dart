import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/models/producto_model.dart';
import 'package:login_bloc/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  final productosProvider = ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        //un comentario
      ),
      body: _crearLista(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearLista() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder:
          //Especificar la lista de ProductoModel que contiene el snapshot
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final totalprod = snapshot.data;
          return ListView.builder(
            itemCount: totalprod.length,
            itemBuilder: (context, i) => _crearItem(context, totalprod[i]),
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

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          productosProvider.borrarProductos(producto.id);
        },
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
                title: Text('${producto.titulo} - ${producto.valor}'),
                subtitle: Text(producto.id),
                onTap: () => Navigator.pushNamed(context, 'producto',
                    arguments: producto),
              ),
            ],
          ),
        ));
  }
}
