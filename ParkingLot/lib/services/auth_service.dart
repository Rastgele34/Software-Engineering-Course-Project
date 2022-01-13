import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //giriş yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  //kayıt ol fonksiyonu
  Future<User?> createPerson(
      String name, String surname, String email, String password) async {
    //await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((users) {FirebaseFirestore.instance.collection("Users").doc(email).set({'UserType': "Customer", 'Wallet': 0.00});});

    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("Users").doc(user.user!.email).set({
      'Email': email,
      'UserType': "Customer",
      'Wallet': 0.00,
      'Name': name,
      'Surname': surname,
      'ReservationID': "null",
    });

    return user.user;
  }
}
