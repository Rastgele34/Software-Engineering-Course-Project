import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

updateHourlyFee(int fee) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  if (fee > 0) {
    await FirebaseFirestore.instance
        .collection('Owners')
        .doc(_auth.currentUser?.email)
        .update({'HourlyFee': fee});
  }
}

updateCapacity(int cap) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var parking = await FirebaseFirestore.instance
      .collection('Owners')
      .doc(_auth.currentUser?.email)
      .get();

  if (cap > 0 &&
      cap > parking.data()!['Reservations'] &&
      cap > parking.data()!['Occupancy']) {
    FirebaseFirestore.instance
        .collection('Owners')
        .doc(_auth.currentUser?.email)
        .update({'Capacity': cap});
  }
}

updateOccupancy(int occ) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var parking = await FirebaseFirestore.instance
      .collection('Owners')
      .doc(_auth.currentUser?.email)
      .get();

  if (occ >= 0 &&
      occ >= parking.data()!['Reservations'] &&
      occ <= parking.data()!['Capacity']) {
    FirebaseFirestore.instance
        .collection('Owners')
        .doc(_auth.currentUser?.email)
        .update({'Occupancy': occ});
  }
}

incrementOccupancy() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var parking = await FirebaseFirestore.instance
      .collection('Owners')
      .doc(_auth.currentUser?.email)
      .get();

  if (parking.data()!['Occupancy'] < parking.data()!['Capacity']) {
    FirebaseFirestore.instance
        .collection('Owners')
        .doc(_auth.currentUser?.email)
        .update({'Occupancy': parking.data()!['Occupancy'] + 1});
  }
}

decrementOccupancy() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var parking = await FirebaseFirestore.instance
      .collection('Owners')
      .doc(_auth.currentUser?.email)
      .get();

  if (parking.data()!['Occupancy'] > parking.data()!['Reservations'] &&
      parking.data()!['Occupancy'] > 0) {
    FirebaseFirestore.instance
        .collection('Owners')
        .doc(_auth.currentUser?.email)
        .update({'Occupancy': parking.data()!['Occupancy'] - 1});
  }
}
