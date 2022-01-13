import 'package:flutter/material.dart';

class ActiveReservationPage extends StatefulWidget {
  const ActiveReservationPage({Key? key}) : super(key: key);

  @override
  _ActiveReservationPageState createState() => _ActiveReservationPageState();
}

class _ActiveReservationPageState extends State<ActiveReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Reservation"),
      ),
    );
  }
}
