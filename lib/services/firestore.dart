import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  final db = FirebaseFirestore.instance;

  Future<void> createUserInFirestore(user) async {
    print(user);
  }
}
