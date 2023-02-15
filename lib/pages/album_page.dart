import 'package:flutter/material.dart';
import 'package:jarmpnj/pages/viewer_page.dart';
import 'package:jarmpnj/services/firestore_service.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class AlbumPage extends StatefulWidget {
  final Album album;

  const AlbumPage({
    super.key,
    required this.album,
  });

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<Medium>? _media;
  bool backup = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }

  void jumpToImage(int index) {
    final vH = scrollController.position.viewportDimension;
    final currentPixels = scrollController.position.pixels;
    final maxView = currentPixels + vH - 50;
    final itemCount = (_media!.length).round();
    final height = scrollController.position.maxScrollExtent + vH;
    final remainder = index % 3;
    final value = ((index - remainder) / itemCount) * height;
    if (value >= currentPixels && value <= maxView) {
      return;
    }
    scrollController.jumpTo(value);
  }

  void switchBackup(value) {
    if (value) {
      FirestoreService().createAlbumInFirestore(_media, widget.album.name);
    }
    setState(() {
      backup = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.name ?? "Unnamed Album"),
        bottom: PreferredSize(
          preferredSize: const Size(20, 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Backup',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Switch(
                  value: backup,
                  onChanged: (value) => switchBackup(value),
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          controller: scrollController,
          children: <Widget>[
            ...?_media?.asMap().entries.map((entry) {
              int index = entry.key;
              Medium medium = entry.value;
              return GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => ViewerPage(
                          medium: medium,
                          initialIndex: index,
                          media: _media!,
                        ),
                      ),
                    )
                    .then((value) => jumpToImage(value)),
                child: Hero(
                  tag: medium.id,
                  child: Container(
                    color: Colors.grey[300],
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: MemoryImage(kTransparentImage),
                      image: ThumbnailProvider(
                        mediumId: medium.id,
                        mediumType: medium.mediumType,
                        highQuality: true,
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
