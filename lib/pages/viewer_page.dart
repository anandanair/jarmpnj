import 'package:flutter/material.dart';
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
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.star_border))
        ],
      ),
      body: Hero(
        tag: medium.id,
        child: Container(
          alignment: Alignment.center,
          child: medium.mediumType == MediumType.image
              ? Image(
                  image: PhotoProvider(mediumId: medium.id),
                  fit: BoxFit.cover ,
                )
              // FadeInImage(
              //     fit: BoxFit.cover,
              //     placeholder: MemoryImage(kTransparentImage),
              //     image: PhotoProvider(mediumId: medium.id),
              //   )
              : VideoProvider(mediumId: medium.id),
        ),
      ),
    );
  }
}
