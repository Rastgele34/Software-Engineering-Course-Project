import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneraterQRCode extends StatefulWidget {
  const GeneraterQRCode({Key? key}) : super(key: key);

  @override
  _GeneraterQRCodeState createState() => _GeneraterQRCodeState();
}

class _GeneraterQRCodeState extends State<GeneraterQRCode> {
  @override
  Widget build(BuildContext context) {
    String? email = 'User email';
    var currenUser = FirebaseAuth.instance.currentUser;
    if (currenUser != null) {
      email = currenUser.email;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr Code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(email!),
              QrImage(
                data: email,
                size: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
