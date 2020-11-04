import 'package:componentes/src/providers/menu_provider.dart';
import 'package:componentes/src/utils/iconos_string_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
        centerTitle: true,
      ),
      body: _lista(),
    );
  }

  //metodo que carga _listaItems
  Widget _lista() {
    //Constuye un future para manejar el estado
    return FutureBuilder(
      //Enlazado al future que estamos esperando
      future: menuProvider.cargarData(),
      //Opcional, informacion por default mientras no se ha resuelto el future
      //Y que es recibida por snapshot.data
      initialData: [],
      //Permite redibujar sobre la pantalla
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );
  }

  //Lista qu devuelve una lista de ListTiles
  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    //for each que recorre data(snapshot.dat = opciones de menuProvider)

    data.forEach((opt) {
      //Widget temporal que almacena objetos
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.blue,
        ),
        onTap: () {
          // final route = MaterialPageRoute(builder: (context) => AlertPage());
          // //Navigator necesita dos parametros, el context que proviene del BuildContext
          // // y route, que es la ruta de la nueva pagina
          // Navigator.push(context, route);

          //Llamado a un pushedName cuyo name de la ruta debe de estar definido
          //el main como route
          Navigator.pushNamed(context, opt['ruta']);
        },
      );
      //Anade el contenido de widgetTemp a la lista opciones
      opciones..add(widgetTemp)..add(Divider());
    });
    //Devuelve la lista opciones siguiendo la estructura
    //del json
    return opciones;
  }
}
