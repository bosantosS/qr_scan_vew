import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_new/providers/scan_list_provider.dart';
import 'package:qr_scan_new/utils/utils.dart';

class ScanBtn extends StatefulWidget {
  //const ScanBtn({Key key}) : super(key: key);

  @override
  _ScanBtnState createState() => _ScanBtnState();
}

class _ScanBtnState extends State<ScanBtn> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print('El result del QR> $barcodeScanRes');
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      print('El valor> $_scanBarcode');
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        
        
        print('Scan...');
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     "0xFF0xFFe94560", 'CANCEL', false, ScanMode.QR);
        // print('$barcodeScanRes');
        await scanQR();
        if(this._scanBarcode=='-1'){
          return;
        }
        // <ModeloARedibujarse>
        final scanListProv = Provider.of<ScanListProvider>(context,listen: false);
        final scan = await scanListProv.nuevoScan(this._scanBarcode);
        launchURL(context, scan);
      },
    );
  }
}
