import 'package:flutter/material.dart';

import 'package:qr_scan_new/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  // Actualiza la GUI de manera centralizada

  List<ScanModel> scans = [];

  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final newScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScanRaw(newScan);
    newScan.id = id;

    if (this.tipoSeleccionado == newScan.tipo) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipos(String tipo) async {
    final scans = await DBProvider.db.getScansForTypes(tipo);
    this.scans = [...scans];
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
    //this.cargarScansPorTipos(this.tipoSeleccionado);
    
  }
}
