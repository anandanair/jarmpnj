import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jarmpnj/components/my_extended_floating_button.dart';
import 'package:jarmpnj/pages/album_page.dart';
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
            // double ratio = gridWidth / gridHeight;
            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    delegate: SliverChildListDelegate([
                      const MyExtendedFloatingButton(
                        iconData: Icons.favorite,
                        text: 'Favorites',
                      ),
                      const MyExtendedFloatingButton(
                        iconData: Icons.delete,
                        text: 'Trash',
                      ),
                      const MyExtendedFloatingButton(
                        iconData: Icons.delete,
                        text: 'Trash',
                      ),
                      const MyExtendedFloatingButton(
                        iconData: Icons.delete,
                        text: 'Trash',
                      ),
                    ]),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 25),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: gridHeight + 70,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.primary.withAlpha(25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Photos on Device",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "View All",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                ...?_albums?.map((album) => GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AlbumPage(album: album))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                color: Colors.grey[300],
                                                height: gridWidth,
                                                width: gridWidth,
                                                child: FadeInImage(
                                                  fit: BoxFit.cover,
                                                  placeholder: MemoryImage(
                                                      kTransparentImage),
                                                  image: AlbumThumbnailProvider(
                                                    albumId: album.id,
                                                    mediumType:
                                                        album.mediumType,
                                                    highQuality: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              padding: const EdgeInsets.only(
                                                  left: 2.0),
                                              child: Text(
                                                album.name ?? "Unnamed Album",
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              padding: const EdgeInsets.only(
                                                  left: 2.0),
                                              child: Text(
                                                album.count.toString(),
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    delegate: SliverChildListDelegate([
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.teal[100],
                        child: const Text("He'd have you all unravel at the"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.teal[200],
                        child: const Text('Heed not the rabble'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.teal[300],
                        child: const Text('Sound of screams but the'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.teal[400],
                        child: const Text('Who scream'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.teal[500],
                        child: const Text('Revolution is coming...'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.teal[600],
                        child: const Text('Revolution, they...'),
                      ),
                    ]),
                  ),
                )
              ],
            );
          });
  }
}
