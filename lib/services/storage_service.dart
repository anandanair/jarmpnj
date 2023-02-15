import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jarmpnj/services/auth.dart';
import 'package:photo_gallery/photo_gallery.dart';

class StorageService {
  final storage = FirebaseStorage.instance;
  final User? user = Auth().currentUser;
  bool uploading = false;
  double uploadProgress = 0;

  void uploadFiles(media, albumName) async {
    // Create the reference to storage
    Reference storageRef =
        storage.ref(user!.uid).child('backup').child(albumName);

    uploading = true;
    int totalFiles = media.length;
    int fileIndex = 1;

    //Upload each file
    for (Medium medium in media) {
      final File file = await medium.getFile();
      String fileName = file.path.split('/').last;
      Reference fileRef = storageRef.child(fileName);

      UploadTask uploadTask =
          fileRef.putFile(file, SettableMetadata(contentType: medium.mimeType));

      await uploadTask.whenComplete(() {
        uploadProgress = (fileIndex / totalFiles) * 100;
        print(uploadProgress);
        fileIndex = fileIndex++;
      });
    }
    uploading = false;
  }
}
