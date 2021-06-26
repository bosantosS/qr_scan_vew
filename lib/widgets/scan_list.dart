import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_new/providers/scan_list_provider.dart';
import 'package:qr_scan_new/utils/utils.dart';

class ScanList extends StatelessWidget {
  //const ScanList({Key key}) : super(key: key);

  final String tipo;

  const ScanList({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    // Dentro de un build, true.
    // Dentro de un metodo, false.
    final scanListProv = Provider.of<ScanListProvider>(context);
    final scans = scanListProv.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (BuildContext context, int ind) => Dismissible(
        key: UniqueKey(), //Key automatico
        background: Container(
          color: Color(0xFFe94560),
        ),
        onDismissed: (DismissDirection direction) => {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScanById(scans[ind].id)
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http' ? Icons.home_outlined : Icons.map_outlined, 
            color: Theme.of(context).primaryColor),
          title: Text(scans[ind].valor),
          subtitle: Text(scans[ind].id.toString()),
          trailing: Icon(Icons.arrow_right),
          onTap: () => launchURL(context, scans[ind]),
        ),
      ),
    );
  }
}
