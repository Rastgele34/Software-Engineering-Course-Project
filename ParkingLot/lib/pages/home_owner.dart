import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/login.dart';
import 'package:parkinglot/pages/owner_wallet.dart';
import 'package:parkinglot/pages/reservations.dart';
import 'package:parkinglot/pages/scan_qr_code.dart';
import 'package:parkinglot/pages/update_parking_lot.dart';
import 'package:parkinglot/services/auth_service.dart';

class HomeOwnerPage extends StatefulWidget {
  const HomeOwnerPage({Key? key}) : super(key: key);

  @override
  _HomeOwnerPageState createState() => _HomeOwnerPageState();
}

class _HomeOwnerPageState extends State<HomeOwnerPage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Owner Home Page"), actions: <Widget>[
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              return Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (Route<dynamic> route) => false);
            });
          },
          icon: Icon(Icons.exit_to_app),
        ),
      ]),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: size.height * .5,
            width: size.width * .85,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.75),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.75),
                      blurRadius: 10,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UpdateParkingLotPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            //color: colorPrimaryShade,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                              child: Text(
                            "Update the Parking Lot",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ReservationsPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            //color: colorPrimaryShade,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                              child: Text(
                            "Reservations",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScanQrCodePage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            //color: colorPrimaryShade,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                              child: Text(
                            "Scan QR code",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OwnerWalletPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            //color: colorPrimaryShade,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                              child: Text(
                            "Wallet",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
