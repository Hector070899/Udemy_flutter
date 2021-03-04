import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:qrscanner/providers/db_provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
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
              onPressed: () {
                final scanListProvider =
                    Provider.of<ScanListProvider>(context, listen: false);
                scanListProvider.borrarTodos();
              })
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
    //final tempScan = ScanModel(valor: 'http://google.com');
    // DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.getScanById(7).then((scan) => print(scan.valor));
    //DBProvider.db.getTodos().then(print);
    //DBProvider.db.deleteAllScans().then(print);

    //Usar ScanLIstProvider
    //Se necestia que busque una instancia de ScanListProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();

      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();

        break;
      default:
        return MapasPage();
    }
  }
}
