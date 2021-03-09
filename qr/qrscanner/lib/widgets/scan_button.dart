import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/util/util.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        final barcodeScanRes = 'geo:12.119471338224349,-86.26552552047393';
        // final barcodeScanRes = 'https://fernando-herrera.com';
        print(barcodeScanRes);

        if (barcodeScanRes == '-1') {
          return;
        }
        //Buscar en el arbol de widgets la instancia de ScanListProvider
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        //Metodo para entrar al valor del scan desde que se pulsa el boton para scanear
        launchUrl(context, nuevoScan);
      },
    );
  }
}
