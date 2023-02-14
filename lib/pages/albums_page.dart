import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  // State
  List<Album>? _albums;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid &&
            await Permission.photos.request().isGranted &&
            await Permission.videos.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : LayoutBuilder(builder: (context, constraints) {
            double gridWidth = (constraints.maxWidth - 20) / 3;
            double gridHeight = gridWidth + 33;
            double ratio = gridWidth / gridHeight;
            return Container(
              padding: const EdgeInsets.all(5),
              child: GridView.count(
                childAspectRatio: ratio,
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                children: <Widget>[
                  ...?_albums?.map((album) => GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
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
                                style: const TextStyle(
                                  height: 1.2,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Text(
                                album.count.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  height: 1.2,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            );
          });
  }
}
