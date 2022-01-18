import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkinglot/services/update.dart';

class UpdateParkingLotPage extends StatefulWidget {
  const UpdateParkingLotPage({Key? key}) : super(key: key);

  @override
  State<UpdateParkingLotPage> createState() => _UpdateParkingLotPageState();
}

class _UpdateParkingLotPageState extends State<UpdateParkingLotPage> {
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _occupancyController = TextEditingController();
  final TextEditingController _hourlyFeeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _usersStream = FirebaseFirestore.instance
        .collection('Owners')
        .doc(_auth.currentUser?.email)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update the Parking Lot"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      StreamBuilder(
                        stream: _usersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot asyncSnapshot) {
                          if (asyncSnapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (asyncSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading");
                          }
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  //color: colorPrimaryShade,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${asyncSnapshot.data.data()['ParkingLotName']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "${asyncSnapshot.data.data()['County']} / ${asyncSnapshot.data.data()['City']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "${asyncSnapshot.data.data()['Address']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "Reservations: ${asyncSnapshot.data.data()['Reservations']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ), //HourlyFee
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                        stream: _usersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot asyncSnapshot) {
                          if (asyncSnapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (asyncSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading");
                          }
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  //color: colorPrimaryShade,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                    child: Text(
                                  "Hourly Fee: \$${asyncSnapshot.data.data()['HourlyFee']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                              ),
                            ),
                          );
                        },
                      ), //HourlyFee
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextField(
                          controller: _hourlyFeeController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.money,
                              color: Colors.white,
                            ),
                            hintText: '\$ Amount',
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
                          updateHourlyFee(int.parse(_hourlyFeeController.text));
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
                              "Update Hourly Fee",
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
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                        stream: _usersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot asyncSnapshot) {
                          if (asyncSnapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (asyncSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading");
                          }
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  //color: colorPrimaryShade,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                    child: Text(
                                  "Capacity: ${asyncSnapshot.data.data()['Capacity']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                              ),
                            ),
                          );
                        },
                      ), //Capacity
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextField(
                          controller: _capacityController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.money,
                              color: Colors.white,
                            ),
                            hintText: 'Amount',
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
                          updateCapacity(int.parse(_capacityController.text));
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
                              "Update Capacity",
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
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                        stream: _usersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot asyncSnapshot) {
                          if (asyncSnapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (asyncSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading");
                          }
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  //color: colorPrimaryShade,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                    child: Text(
                                  "Occupancy: ${asyncSnapshot.data.data()['Occupancy']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                              ),
                            ),
                          );
                        },
                      ), //HourlyFee
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextField(
                          controller: _occupancyController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.money,
                              color: Colors.white,
                            ),
                            hintText: 'Amount',
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
                          updateOccupancy(int.parse(_occupancyController.text));
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
                              "Update Occupancy",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              decrementOccupancy();
                            },
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
                                  "       -       ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.07,
                          ),
                          InkWell(
                            onTap: () {
                              incrementOccupancy();
                            },
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
                                  "       +       ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
