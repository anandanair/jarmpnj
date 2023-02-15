import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jarmpnj/models/user_model.dart';
import 'package:jarmpnj/services/auth.dart';
import 'package:photo_gallery/photo_gallery.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;
  final User? user = Auth().currentUser;

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

  Future<void> createAlbumInFirestore(albumName, size) async {
    await db.collection("users").doc(user!.uid).update({
      'albums': FieldValue.arrayUnion(
        [
          {
            'albumName': albumName,
            'size': size,
            'backup': true,
          }
        ],
      ),
    });
  }

  Future<void> createFileInFirestore(
      Medium medium, albumName, downloadURL) async {
    await db
        .collection("users")
        .doc(user!.uid)
        .collection("backup")
        .doc(medium.filename)
        .set({
      "fileName": medium.filename,
      "creationDate": medium.creationDate,
      "duration": medium.duration,
      "mediumType": medium.mediumType.toString(),
      "mimeType": medium.mimeType,
      "modifiedDate": medium.modifiedDate,
      "orientation": medium.orientation,
      "id": medium.id,
      "url": downloadURL,
      "albumName": albumName,
    });
  }

  checkBackupEnabled(albumName) async {
    final docRef = db.collection("users").doc(user!.uid).withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel userModel, _) => userModel.toFirestore(),
        );
    final docSnap = await docRef.get();
    final userModel = docSnap.data();

    if (userModel != null) {
      if (userModel.albums != null) {
        final album =
            userModel.albums!.where((album) => album['albumName'] == albumName);
        if (album.isNotEmpty) {
          return album.first['backup'];
        }
        return false;
      }
    }
  }
}
