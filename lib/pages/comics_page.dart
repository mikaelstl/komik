import 'package:flutter/material.dart';
import 'package:komik/components/labels/not_found_comics.dart';
import 'package:komik/components/lists/comics_founded.dart';
import 'package:komik/service/managers/comic_manager.dart';

class ComicsPage extends StatelessWidget {
  final ComicManager comicManager;

  const ComicsPage({
    super.key,
    required this.comicManager
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      clipBehavior: Clip.none,
      child: comicManager.data.isEmpty
              ? Center(child: NotFoundComics())
              : ComicsFounded(with_section: false,comics: comicManager.data)
      );
  }
}
