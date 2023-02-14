import 'package:flutter/material.dart';
import 'package:jarmpnj/components/my_button.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyButton(onTap: () {}, text: "Back Up Photos"),
    );
  }
}
