import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';

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

        final barcodeScanRes = 'https://fernando-herrera.com';
        print(barcodeScanRes);
        //Buscar en el arbol de widgets la instancia de ScanListProvider
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);
        scanListProvider.nuevoScan('geo: 15.33, 15.66');
        scanListProvider.nuevoScan(barcodeScanRes);
        scanListProvider.nuevoScan('geo: 15.33, 15.66');
        scanListProvider.nuevoScan(barcodeScanRes);
        scanListProvider.nuevoScan('geo: 15.33, 15.66');
        print(scanListProvider.tipoSeleccionado);
      },
    );
  }
}
