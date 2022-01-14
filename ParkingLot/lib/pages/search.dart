import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/services/reservation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _countyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance.collection('Owners').snapshots();

  final String? userEmail = FirebaseAuth.instance.currentUser?.email;

  f() {
    _usersStream = FirebaseFirestore.instance
        .collection('Owners')
        .where('County', isEqualTo: _countyController.text)
        .where('City', isEqualTo: _cityController.text)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    f();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            //height: size.height * .5,
            //width: size.width * .85,
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
                  children: [
                    TextField(
                        controller: _countyController,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          hintText: 'County',
                          prefixText: ' ',
                          hintStyle: TextStyle(color: Colors.white),
                          focusColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                        )),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextField(
                        controller: _cityController,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          hintText: 'City',
                          prefixText: ' ',
                          hintStyle: TextStyle(color: Colors.white),
                          focusColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                        )),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        f();
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
                            "Search",
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
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _usersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading");
                          }

                          return ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(data['ParkingLotName']),
                                      subtitle: Text(data['Address']),
                                    ),
                                    ListTile(
                                      title: Text("\$ ${data['HourlyFee']}"),
                                      subtitle: const Text('Hourly Fee'),
                                    ),
                                    ListTile(
                                      title: Text(
                                          "${data['Occupancy']}/${data['Capacity']}"),
                                      subtitle: const Text("Occupancy"),
                                    ),
                                    InkWell(
                                      onTap: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Reservation'),
                                          content: Text(data['ParkingLotName']),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                String pEmail =
                                                    data['Email'] as String;
                                                if (await isUserAvailable(
                                                        userEmail!) &&
                                                    await isParkingLotAvailable(
                                                        pEmail)) {
                                                  await makeReservation(
                                                      userEmail!, pEmail);
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                          "Reservation is done"),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, 'OK');
                                                          },
                                                          child:
                                                              const Text("OK"),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  if (await isUserAvailable(
                                                          userEmail!) ==
                                                      false) {
                                                    return showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            "You have already a reservation"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK');
                                                            },
                                                            child: const Text(
                                                                "OK"),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  } else if (await isParkingLotAvailable(
                                                          pEmail) ==
                                                      false) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            "Selected Parking Lots is full of capacity"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK');
                                                            },
                                                            child: const Text(
                                                                "OK"),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                }
                                                Navigator.pop(context, 'OK');
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue
                                                      .withOpacity(.75),
                                                  width: 2),
                                              //color: colorPrimaryShade,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30))),
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Center(
                                                child: Text(
                                              "Make a Reservation",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        },
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
        ));
  }
}
