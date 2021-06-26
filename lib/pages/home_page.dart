import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_new/providers/scan_list_provider.dart';


import 'package:qr_scan_new/widgets/custom_navbar.dart';
import 'package:qr_scan_new/widgets/scan_btn.dart';
import 'package:qr_scan_new/pages/direcciones_page.dart';
import 'package:qr_scan_new/pages/mapas_page.dart';
import 'package:qr_scan_new/providers/ui_state_provider.dart';

class HomePage extends StatelessWidget {
  //const name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Se coloca false para que no se redibuje en este punto
    final scanListProv = Provider.of<ScanListProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: () => {
              scanListProv.borrarTodos()
            }
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavBar(),
      floatingActionButton: ScanBtn() ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  //const _HomePageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Obtener el selectedMenuOpt
    final uiProv = Provider.of<UiProvider>(context);
    
    //Se coloca false para que no se redibuje en este punto
    final scanListProv = Provider.of<ScanListProvider>(context, listen: false);

    final currentIndex = uiProv.selectedMenuOpt;

    switch(currentIndex){
      case 0:
        scanListProv.cargarScansPorTipos('geo');
        return MapasPage();
      case 1: 
        scanListProv.cargarScansPorTipos('http');
        return DireccionesPage();

      default: return MapasPage();
    }
  }
}