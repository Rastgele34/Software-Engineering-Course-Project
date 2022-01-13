import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkinglot/services/wallet.dart';

class OwnerWalletPage extends StatefulWidget {
  const OwnerWalletPage({Key? key}) : super(key: key);

  @override
  _OwnerWalletPageState createState() => _OwnerWalletPageState();
}

class _OwnerWalletPageState extends State<OwnerWalletPage> {
  final TextEditingController _depositController = TextEditingController();
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
        title: const Text("Wallet"),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder(
                      stream: _usersStream,
                      builder:
                          (BuildContext context, AsyncSnapshot asyncSnapshot) {
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
                                "\$ ${asyncSnapshot.data.data()['Wallet']}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.12,
                    ),
                    TextField(
                        controller: _depositController,
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
                      onTap: () async {
                        int money = await walletMoneyAmountOwner();
                        if (int.parse(_depositController.text) <= money) {
                          await walletOwnerWithdraw(
                              int.parse(_depositController.text));
                          money = await walletMoneyAmountOwner();
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("Wallet: \$ $money"),
                              content: Text(
                                  "\$ ${int.parse(_depositController.text)} withdrawn"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("Wallet: \$ $money"),
                              content: Text(
                                  "You can not withdraw \$ ${int.parse(_depositController.text)}"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
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
                            "Withdraw Money",
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
