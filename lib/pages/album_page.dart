import 'package:flutter/material.dart';
import 'package:jarmpnj/pages/viewer_page.dart';
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
                  onChanged: (value) {
                    setState(() {
                      backup = value;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          ...?_media?.map((medium) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewerPage(medium: medium))),
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
              ))
        ],
      ),
    );
  }
}
