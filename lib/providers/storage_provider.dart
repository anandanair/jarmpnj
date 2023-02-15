import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../services/auth.dart';

class StorageProvider extends ChangeNotifier {
  final storage = FirebaseStorage.instance;
  final User? user = Auth().currentUser;

  //Internal private state
  double _progress = 0;
  int _uploadedFiles = 0;
  int _totalFiles = 0;
  bool _uploading = false;
  final List _queue = [];

  double get progress => _progress;
  int get totalFiles => _totalFiles;
  int get uploadedFiles => _uploadedFiles;

  void uploadFiles(media, albumName) async {
// Update upload data
    _totalFiles = media.length + _totalFiles;

    // Only start uploading if there is no upload in progress
    if (!_uploading) {
      // Set uploading to true
      _uploading = true;

      // Create the reference to storage
      Reference storageRef =
          storage.ref(user!.uid).child('backup').child(albumName);

      //Upload each file
      for (Medium medium in media) {
        final File file = await medium.getFile();
        String fileName = file.path.split('/').last;
        Reference fileRef = storageRef.child(fileName);

        UploadTask uploadTask = fileRef.putFile(
            file, SettableMetadata(contentType: medium.mimeType));

        await uploadTask.whenComplete(() {
          _uploadedFiles++;
          _progress = (_uploadedFiles / _totalFiles) * 100;
          notifyListeners();
        });
      }

      // Set uploading to false when all upload is finished.
      _uploading = false;
      if (_queue.isNotEmpty) {
        // Upload first album in the queue
        uploadFiles(_queue[0].media, _queue[0].albumName);
        _queue.removeAt(0);
      } else {
        _progress = 100.0;
      }
    } else {
      // Add files to upload to Queue
      _queue.add(UploadData(media: media, albumName: albumName));
    }
  }
}

// Upload Data class
class UploadData {
  List<Medium> media;
  String albumName;

  UploadData({required this.media, required this.albumName});
}
