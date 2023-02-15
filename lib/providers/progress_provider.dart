import 'package:flutter/material.dart';

class ProgressModel extends ChangeNotifier {
  //Internal private state
  final double _progress = 0;
  // double _progress = 0;
  int _uploadedFiles = 0;
  int _totalFiles = 0;

  double get progress => _progress;
  int get totalFiles => _totalFiles;
  int get uploadedFiles => _uploadedFiles;
}
