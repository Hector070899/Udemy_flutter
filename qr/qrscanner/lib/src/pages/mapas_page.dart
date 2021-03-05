import 'package:flutter/material.dart';
import 'package:qrscanner/widgets/scan_list.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Es necesario escuchar los cambios para redibujar y mostrar info en la UI
    return ScanList(tipo: 'geo');
  }
}
