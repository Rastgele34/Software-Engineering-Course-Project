import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> isUserAvailable(String user) async {
  String res = "";

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(user)
      .get()
      .then((value) {
    res = value.data()!['ReservationID'];
  });

  if (res == "null") {
    return true;
  } else {
    return false;
  }
}

Future<bool> isParkingLotAvailable(String parkingLot) async {
  int occ = 0;
  int cap = 0;

  await FirebaseFirestore.instance
      .collection('Owners')
      .doc(parkingLot)
      .get()
      .then((value) {
    occ = value.data()!['Occupancy'] as int;
    cap = value.data()!['Capacity'] as int;
  });

  if (occ < cap) {
    return true;
  } else {
    return false;
  }
}

Future<void> makeReservation(String user, String parkingLot) async {
  int occ = 0;
  int cap = 0;
  int res = 0;

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(user)
      .update({'ReservationID': parkingLot});

  await FirebaseFirestore.instance
      .collection('Owners')
      .doc(parkingLot)
      .get()
      .then((value) {
    occ = value.data()!['Occupancy'] as int;
    cap = value.data()!['Capacity'] as int;
    res = value.data()!['Reservations'] as int;
  });

  occ++;
  cap++;
  res++;

  await FirebaseFirestore.instance
      .collection('Owners')
      .doc(parkingLot)
      .update({'Occupancy': occ, 'Capacity': cap, 'Reservations': res});

  await FirebaseFirestore.instance.collection('Reservations').doc(user).set({
    'ParkingLot': parkingLot,
    'User': user,
    'ReservationStart': Timestamp.now()
  });
}
