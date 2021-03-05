import 'package:flutter/material.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:qrscanner/providers/db_provider.dart';

//Manejador de los scans para actualizar la UI
class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  //Funcion que recibe como string el valor del scan
  nuevoScan(String valor) async {
    //Crea la instancia pero no lo inserta
    final nuevoScan = ScanModel(valor: valor);
    //Insercion del nuevoScan en la base de datos
    //Recibe el id del ultimo registro insertado
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //Asignar el id de la db al modelo
    nuevoScan.id = id;

    //Condicion que evalua que son del mismo tipo para mostrar en la ui
    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      //Notifica al widget que le interesa saber cuando esto cambia
      notifyListeners();
    }
  }

  cargarScans() async {
    //Regresa un listado de scans
    final scans = await DBProvider.db.getTodos();
    //Asignacion de listado de scans la prop scans
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansByTipo(tipo);
    //Asignacion de listado de scans la prop scans
    this.scans = [...scans];
    //Asignacion para saber el tipo
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  borrarScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    //Se llama el este metodo para cargar los scans
  }
}
