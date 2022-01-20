import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneraterQRCode extends StatefulWidget {
  const GeneraterQRCode({Key? key}) : super(key: key);

  @override
  _GeneraterQRCodeState createState() => _GeneraterQRCodeState();
}

class _GeneraterQRCodeState extends State<GeneraterQRCode> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String? email = 'User email';
    var currenUser = FirebaseAuth.instance.currentUser;
    if (currenUser != null) {
      email = currenUser.email;
    }

    var _stream = FirebaseFirestore.instance
        .collection('Reservations')
        .doc(_auth.currentUser?.email)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr Code'),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (asyncSnapshot.data.data() == null) {
            Navigator.pop(context);
          }
          return Center(
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
          );
        },
      ),
    );
  }
}
