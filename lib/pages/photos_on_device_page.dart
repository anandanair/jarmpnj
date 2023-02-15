import 'package:flutter/material.dart';
import 'package:jarmpnj/pages/album_page.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotosOnDevicePage extends StatefulWidget {
  final List<Album> albums;

  const PhotosOnDevicePage({
    super.key,
    required this.albums,
  });

  @override
  State<PhotosOnDevicePage> createState() => _PhotosOnDevicePageState();
}

class _PhotosOnDevicePageState extends State<PhotosOnDevicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photos on device',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        double gridWidth = (constraints.maxWidth - 30) / 2;
        double gridHeight = gridWidth + 40;
        double ratio = gridWidth / gridHeight;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: ratio,
            children: <Widget>[
              ...widget.albums.map((album) => GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AlbumPage(album: album))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            color: Colors.grey[300],
                            height: gridWidth,
                            width: gridWidth,
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: MemoryImage(kTransparentImage),
                              image: AlbumThumbnailProvider(
                                albumId: album.id,
                                mediumType: album.mediumType,
                                highQuality: true,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            album.name ?? "Unnamed Album",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            album.count.toString(),
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }
}
