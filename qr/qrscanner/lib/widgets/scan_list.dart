import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/util/util.dart';

class ScanList extends StatelessWidget {
  final String tipo;

  const ScanList({@required this.tipo});
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          scanListProvider.borrarScanById(scans[i].id);
          print("El id '${scans[i].id} fue borrado");
        },
        child: ListTile(
          leading: Icon(
            // Condicion ternaria para evaluar el tipo de icono por si es mapa o direccion
            this.tipo == 'http' ? Icons.home_outlined : Icons.map_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchUrl(context, scans[i]),
        ),
      ),
    );
  }
}
