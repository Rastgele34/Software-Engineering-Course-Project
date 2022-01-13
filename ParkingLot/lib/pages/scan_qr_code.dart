import 'package:flutter/material.dart';

class ScanQrCodePage extends StatefulWidget {
  const ScanQrCodePage({Key? key}) : super(key: key);

  @override
  _ScanQrCodePageState createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
    );
  }
}
