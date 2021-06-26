import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_scan_new/pages/home_page.dart';
import 'package:qr_scan_new/pages/mapa_page.dart';
import 'package:qr_scan_new/providers/scan_list_provider.dart';
import 'package:qr_scan_new/providers/ui_state_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //Palete Colors
  final Color _primaryColor = Color(0xFF16213e);
  final Color _accentColor = Color(0xFF16213e);
  //Color(0xFF0f3460);
  //Color(0xFFe94560);
  final Color _backgroundColorWarning = Color(0xFFe94560);
  //Font Styles
  final TextTheme _textTheme = TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => new UiProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => new ScanListProvider(),)

      ],
      child: MaterialApp(
        title: 'QR App',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'mapa': (BuildContext context) => MapaPage(),
        },
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: _primaryColor,
            accentColor: _accentColor,
            textTheme: _textTheme,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: _backgroundColorWarning,
            )),
      ),
    );
  }
}
