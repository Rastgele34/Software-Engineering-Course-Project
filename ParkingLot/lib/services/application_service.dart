import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

denyApplication(String eMail) {
  FirebaseFirestore.instance.collection('Applications').doc(eMail).delete();
}

acceptApplication(String eMail) async {
  var appeal = await FirebaseFirestore.instance
      .collection('Applications')
      .doc(eMail)
      .get();

  var password = appeal.data()!['Password'] as String;
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: eMail, password: password);

  FirebaseFirestore.instance.collection('Owners').doc(eMail).set({
    'Address': appeal.data()!['Address'],
    'Capacity': appeal.data()!['Capacity'],
    'City': appeal.data()!['City'],
    'County': appeal.data()!['County'],
    'Email': appeal.data()!['Email'],
    'HourlyFee': appeal.data()!['HourlyFee'],
    'Occupancy': appeal.data()!['Occupancy'],
    'ParkingLotName': appeal.data()!['ParkingLotName'],
    'Reservations': appeal.data()!['Reservations'],
    'Wallet': appeal.data()!['Wallet'],
  });

  FirebaseFirestore.instance.collection('Applications').doc(eMail).delete();
}
