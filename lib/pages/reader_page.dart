import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/tool-bars/reader_tool_bar.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';
import 'package:komik/service/managers/reading_manager.dart';
import 'package:komik/widgets/page.dart';

class ReaderPage extends StatefulWidget {
  final ReadingManager readingManager;
  final List<Uint8List> Function(String path) fetchPages;

  const ReaderPage({
    super.key,
    required this.fetchPages,
    required this.readingManager,
  });

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  final TransformationController _controller = TransformationController();
  TapDownDetails? _doubleTapDetails;
  final double _zoomScale = 1.8;

  late List<Uint8List> pages = [];
  late ComicReaderInfos infos;
  int actualPageIndex = 0;
  Uint8List actualPage = Uint8List(0);

  @override
  void initState() {
    super.initState();
    _enterFullScreenMode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    infos = ModalRoute.of(context)?.settings.arguments as ComicReaderInfos;
    pages = widget.fetchPages(
      infos.path
    );
    infos.totalPages = pages.length;
    actualPageIndex = infos.initPage;
    actualPage = pages[infos.initPage];
  }

  @override
  void dispose() {
    widget.readingManager.create(
      comicID: infos.comicID,
      actualPage: actualPageIndex,
      totalPages: pages.length
    );

    pages.clear();
    pages = [];
    actualPage = Uint8List(0);
    actualPageIndex = 0;

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReaderToolBar(
        title: infos.title,
      ),
      body: Center(child: _reader()),
      bottomSheet: _pages(),
    );
  }

  Widget _reader() {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onDoubleTapDown: (details) {
          _doubleTapDetails = details;
        },
        onDoubleTap: () {
          final position = _doubleTapDetails!.localPosition;
          final x = -position.dx * (_zoomScale - 1);
          final y = -position.dy * (_zoomScale - 1);

          final zoomed = Matrix4.identity()
                          ..translate(x, y)
                          ..scale(_zoomScale);

          _controller.value = _controller.value.isIdentity()
                          ? zoomed : Matrix4.identity();
        },
        onTapUp: (TapUpDetails details) {
          _controller.value = Matrix4.identity();
          final touchX = details.localPosition.dx;

          if (touchX < width/2) {
            setState(() {
              actualPageIndex--;
              actualPage = isNotFirstPage && isNotLastPage ? pages[actualPageIndex] : pages[actualPageIndex];
            });
          } else {
            setState(() {
              actualPageIndex++;
              actualPage = isNotFirstPage && isNotLastPage ? pages[actualPageIndex] : pages[actualPageIndex];
            });
          }
        },
        child: SizedBox.expand(
          child: PageViewer(
            image: actualPage,
            transformationController: _controller
          ),
        )
      );
  }

  Widget _pages() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      color: Palette.background,
      child: Text('${actualPageIndex+1} - ${infos.totalPages}', style: KomikTypography.base),
    );
  }

  void _enterFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
}

  bool get isNotFirstPage => actualPageIndex > 0;

  bool get isNotLastPage => actualPageIndex < pages.length-1;
}