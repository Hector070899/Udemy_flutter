import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/db_provider.dart';
import 'package:qrscanner/widgets/custom_navigatorbar.dart';
import 'package:qrscanner/widgets/scan_button.dart';
import 'package:qrscanner/src/pages/mapas_page.dart';
import 'package:qrscanner/src/pages/direcciones_page.dart';
import 'package:qrscanner/providers/ui_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _HomePageBody(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigatorBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Se accede al provider a traves del context
    //Obtener el selecetdMenuOpt
    final uiProvider = Provider.of<UiProvider>(context);
    //Se le asigna el valor de selecteMenuOpt a currentIndex para ser usado en el switch
    final currentIndex = uiProvider.selectedMenuOpt;
    //Cambiar el currentIndex para mostrar cada pagina

    //TODO: leer base de datos
    DBProvider.db.database;
    switch (currentIndex) {
      case 0:
        return MapasPage();

      case 1:
        return DireccionesPage();

        break;
      default:
        return MapasPage();
    }
  }
}
