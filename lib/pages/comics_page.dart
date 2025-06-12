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
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: double.infinity,
      child: StreamBuilder(
        stream: comicManager.fetch(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: NotFoundComics()
            );
          }
          return ComicsFounded(with_section: false,comics: snapshot.data!);
        })
      );
  }
}