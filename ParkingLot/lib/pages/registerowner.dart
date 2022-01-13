import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/login.dart';

class RegisterOwnerPage extends StatefulWidget {
  const RegisterOwnerPage({Key? key}) : super(key: key);

  @override
  _RegisterOwnerPageState createState() => _RegisterOwnerPageState();
}

class _RegisterOwnerPageState extends State<RegisterOwnerPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _hourlyFeeController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  Future<void> createOwner() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((owners) {
      FirebaseFirestore.instance
          .collection("Owners")
          .doc(_emailController.text)
          .set({
        'Email': _emailController.text,
        'Wallet': 0.00,
        'Address': _adressController.text,
        'Capacity': _capacityController.text as int,
        'City': _cityController.text,
        'County': _countyController.text,
        'HourlyFee': _hourlyFeeController.text as int,
        'Occupancy': 0,
        'ParkingLotName': _nameController.text,
        'Reservations': 0,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: size.height * .7,
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
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextField(
                          controller: _emailController,
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
                            hintText: 'E-Mail',
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
                      TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.white,
                            ),
                            hintText: 'Password',
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
                      TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.white,
                            ),
                            hintText: 'Parking Lot Name',
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
                      TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: _countyController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
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
                      TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: _cityController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
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
                      TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: _adressController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.white,
                            ),
                            hintText: 'Full Address',
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
                      TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: _hourlyFeeController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.white,
                            ),
                            hintText: 'Hourly Fee',
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
                      TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: _capacityController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.white,
                            ),
                            hintText: 'Capacity',
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
                          createOwner().then((value) {
                            return Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          });
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
                              "Log in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: size.height * .06, left: size.width * .02),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.blue.withOpacity(.75),
                    size: 26,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.3,
                ),
                Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue.withOpacity(.75),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
