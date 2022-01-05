import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageothState createState() => _LoginPageothState();
}

class _LoginPageothState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    TextEditingController t1 = TextEditingController();
    TextEditingController t2 = TextEditingController();

    registerParkingLot() async {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: t1.text, password: t2.text);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Parking Lot | Log in"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: t1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.mail),
                  labelText: "E-mail",
                  suffixText: "@gmail.com",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: t2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.vpn_key),
                  labelText: "Password",
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Log in"),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Register"),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
