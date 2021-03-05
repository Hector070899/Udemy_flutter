import 'package:flutter/material.dart';
import 'package:qrscanner/widgets/scan_list.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanList(tipo: 'http');
  }
}
