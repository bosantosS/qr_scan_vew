import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_new/providers/ui_state_provider.dart';

class CustomNavBar extends StatelessWidget {
  //const CustomNavBar({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final uiProv = Provider.of<UiProvider>(context);
    final currentIndex =uiProv.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int index) => uiProv.selectedMenuOpt = index,
      elevation: 1,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.computer),
          label: 'Dirs'
        )
        
      ],
      currentIndex:currentIndex ,
    );
  }
}