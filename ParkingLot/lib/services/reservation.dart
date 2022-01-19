import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    res = value.data()!['Reservations'] as int;
  });

  var userInfo =
      await FirebaseFirestore.instance.collection('Users').doc(user).get();

  occ++;
  res++;

  await FirebaseFirestore.instance
      .collection('Owners')
      .doc(parkingLot)
      .update({'Occupancy': occ, 'Reservations': res});

  var parking = await FirebaseFirestore.instance
      .collection('Owners')
      .doc(parkingLot)
      .get();

  await FirebaseFirestore.instance.collection('Reservations').doc(user).set({
    'ParkingLot': parkingLot,
    'User': user,
    'ReservationStart': Timestamp.now(),
    'Address': parking.data()!['Address'],
    'City': parking.data()!['City'],
    'County': parking.data()!['County'],
    'HourlyFee': parking.data()!['HourlyFee'],
    'ParkingLotName': parking.data()!['ParkingLotName'],
    'UserName': userInfo.data()!['Name'],
    'UserSurname': userInfo.data()!['Surname'],
  });
}

finalizeReservation(String user) async {
  var res = await FirebaseFirestore.instance
      .collection('Reservations')
      .doc(user)
      .get();

  var timeR = res.data()!['ReservationStart'];
  Timestamp time = timeR;
  var date = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);

  var now = DateTime.now();

  int durationHour = now.difference(date).inHours;
  int durationMinute = now.difference(date).inMinutes;
  int hourlyFee = res.data()!['HourlyFee'];
  int fee = 0;

  fee = fee + (hourlyFee * durationHour);

  if (durationMinute % 60 > 0) {
    fee = fee + hourlyFee;
  }

  String ownerEmail = await res.data()!['ParkingLot'];
  var _user =
      await FirebaseFirestore.instance.collection('Users').doc(user).get();
  var _owner = await FirebaseFirestore.instance
      .collection('Owners')
      .doc(ownerEmail)
      .get();

  await FirebaseFirestore.instance.collection('Users').doc(user).update(
      {'Wallet': await _user.data()!['Wallet'] - fee, 'ReservationID': 'null'});

  await FirebaseFirestore.instance.collection('Owners').doc(ownerEmail).update({
    'Wallet': await _owner.data()!['Wallet'] + fee,
    'Reservations': await _owner.data()!['Reservations'] - 1,
    'Occupancy': await _owner.data()!['Occupancy'] - 1,
  });

  await FirebaseFirestore.instance
      .collection('Reservations')
      .doc(user)
      .delete();
}

Future<bool> scanFinalizeReservation(String user) async {
  var currentUserEmail = FirebaseAuth.instance.currentUser?.email as String;
  var _res = await FirebaseFirestore.instance
      .collection('Reservations')
      .doc(user)
      .get();

  if (_res.data() == null) {
    return false;
  }

  var ownerEmail = _res.data()!['ParkingLot'] as String;

  if (currentUserEmail == ownerEmail) {
    await finalizeReservation(user);
    return true;
  } else {
    return false;
  }
}
