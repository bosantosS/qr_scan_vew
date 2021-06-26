import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_new/providers/scan_list_provider.dart';
import 'package:qr_scan_new/widgets/scan_list.dart';

class DireccionesPage extends StatelessWidget {
  //const DireccionesPage({Key key}) : //super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScanList(tipo: 'http');

  }
}