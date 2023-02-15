import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? displayName;
  final String? email;
  final String? photoURL;
  final String? uid;
  final List? albums;

  UserModel({
    this.displayName,
    this.email,
    this.photoURL,
    this.uid,
    this.albums,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      displayName: data?['displayName'],
      email: data?['email'],
      photoURL: data?['photoURL'],
      uid: data?['uid'],
      albums: data?['albums'] is Iterable ? List.from(data?['albums']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (displayName != null) "displayName": displayName,
      if (email != null) "email": email,
      if (photoURL != null) "photoURL": photoURL,
      if (uid != null) "uid": uid,
      if (albums != null) "albums": albums,
    };
  }
}
