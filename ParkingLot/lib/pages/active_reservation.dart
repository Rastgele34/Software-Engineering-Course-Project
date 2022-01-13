import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActiveReservationPage extends StatefulWidget {
  const ActiveReservationPage({Key? key}) : super(key: key);

  @override
  _ActiveReservationPageState createState() => _ActiveReservationPageState();
}

class _ActiveReservationPageState extends State<ActiveReservationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var _stream = FirebaseFirestore.instance
        .collection('Reservations')
        .doc(_auth.currentUser?.email)
        .snapshots();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Reservation"),
      ),
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
                child: StreamBuilder(
                  stream: _stream,
                  builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                    if (asyncSnapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    var timeR = asyncSnapshot.data.data()['ReservationStart'];
                    Timestamp time = timeR;
                    var date = DateTime.fromMicrosecondsSinceEpoch(
                        time.microsecondsSinceEpoch);

                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              //color: colorPrimaryShade,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    '${asyncSnapshot.data.data()['ParkingLotName']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${asyncSnapshot.data.data()['County']} / ${asyncSnapshot.data.data()['City']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${asyncSnapshot.data.data()['Address']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Hourly Fee: \$${asyncSnapshot.data.data()['HourlyFee']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              //color: colorPrimaryShade,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                const Center(
                                  child: Text(
                                    'Start Time',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '$date',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                //color: colorPrimaryShade,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                  child: Text(
                                "Get QR Code",
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
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
