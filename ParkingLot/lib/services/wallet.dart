import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<int> walletMoneyAmount() async {
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;
  int money = 0;

  await FirebaseFirestore.instance
      .collection("Users")
      .doc(userEmail)
      .get()
      .then((value) {
    money = value.data()!['Wallet'] as int;
  });

  return money;
}

walletUserDeposit(int deposit) async {
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;
  int money = 0;

  await FirebaseFirestore.instance
      .collection("Users")
      .doc(userEmail)
      .get()
      .then((value) {
    money = value.data()!['Wallet'] as int;
  });

  money = money + deposit;

  await FirebaseFirestore.instance
      .collection("Users")
      .doc(userEmail)
      .update({"Wallet": money});
}

Future<int> walletMoneyAmountOwner() async {
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;
  int money = 0;

  await FirebaseFirestore.instance
      .collection("Owners")
      .doc(userEmail)
      .get()
      .then((value) {
    money = value.data()!['Wallet'] as int;
  });

  return money;
}

walletOwnerWithdraw(int withdraw) async {
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;
  int money = 0;

  await FirebaseFirestore.instance
      .collection("Owners")
      .doc(userEmail)
      .get()
      .then((value) {
    money = value.data()!['Wallet'] as int;
  });

  if (withdraw <= money) {
    money = money - withdraw;
  }

  await FirebaseFirestore.instance
      .collection("Owners")
      .doc(userEmail)
      .update({"Wallet": money});
}
