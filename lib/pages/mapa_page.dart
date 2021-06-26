import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_scan_new/providers/db_provider.dart';
//Google maps
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  //const MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  //Future del google maps ctrl
  Completer<GoogleMapController> _controller = Completer();

  //Configuracion inicial de la camara
  final CameraPosition ptoInicial = CameraPosition(
    target: LatLng(-1.160171, -78.432915),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: ptoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
