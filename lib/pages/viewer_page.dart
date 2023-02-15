import 'package:flutter/material.dart';
import 'package:jarmpnj/pages/video_provider.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewerPage extends StatefulWidget {
  final Medium medium;
  final int initialIndex;
  final List<Medium> media;

  ViewerPage({
    super.key,
    required this.medium,
    required this.initialIndex,
    required this.media,
  }) : pageController = PageController(initialPage: initialIndex);

  final PageController pageController;

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // DateTime? date = medium.creationDate ?? medium.modifiedDate;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.star_border))
        ],
      ),
      body: widget.medium.mediumType == MediumType.image
          ? PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              itemCount: widget.media.length,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider:
                      PhotoProvider(mediumId: widget.media[index].id),
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: widget.media[index].id),
                );
              },
              loadingBuilder: (context, event) => const Center(
                child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator()),
              ),
              backgroundDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background),
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
            )
          : VideoProvider(mediumId: widget.medium.id),
    );
  }
}
