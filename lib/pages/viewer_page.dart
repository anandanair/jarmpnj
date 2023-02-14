import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jarmpnj/pages/video_provider.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class ViewerPage extends StatelessWidget {
  final Medium medium;

  const ViewerPage({
    super.key,
    required this.medium,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? date = medium.creationDate ?? medium.modifiedDate;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: medium.mediumType == MediumType.image
            ? FadeInImage(
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: PhotoProvider(mediumId: medium.id),
              )
            : VideoProvider(mediumId: medium.id),
      ),
    );
  }
}
