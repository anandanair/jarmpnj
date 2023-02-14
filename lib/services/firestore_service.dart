import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jarmpnj/auth.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  void checkUserExists() {
    // check if user already exists in firestore
    final currentUser = Auth().currentUser;
    final docRef = db.collection("users").doc(currentUser!.uid);
    docRef.get().then((doc) {
      if (!doc.exists) {
        // Create new data in Firestore
        createUserInFirestore(currentUser);
      }
    });
  }

  void createUserInFirestore(User? currentUser) async {
    final docRef = db.collection("users").doc(currentUser!.uid);
    await docRef.set({
      'uid': currentUser.uid,
      'email': currentUser.email,
      'displayName': currentUser.displayName,
      'photoURL': currentUser.photoURL,
    });
  }
}