import 'package:flutter/material.dart';
import 'package:komik/components/labels/not_found_comics.dart';
import 'package:komik/components/lists/comics_founded.dart';
import 'package:komik/components/lists/collections_founded.dart';
import 'package:komik/components/tool-bars/search_bar.dart';
import 'package:komik/components/utils/checkboxes/check_mode.dart';
import 'package:komik/l10n/app_localizations.dart';
import 'package:komik/service/managers/collection_manager.dart';
import 'package:komik/service/managers/comic_manager.dart';
import 'package:komik/service/utils/states/search_filter_type.dart';

class SearchPage extends StatefulWidget {
  final ComicManager comicManager;
  final CollectionManager collectionManager;

  const SearchPage({
    super.key,
    required this.comicManager,
    required this.collectionManager
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController(text: '');
  String _pattern = '';

  bool seeComics = true;
  bool seeCollections = true;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() => _pattern = controller.text);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchToolBar(
          controller: controller,
        ),
        body: Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            spacing: 20,
            children: [
              _filter(),
              _results()
            ],
          )
        )
      ),
    );
  }

  Widget _filter(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
      spacing: 12,
      children: [
        CheckMode(
          label: AppLocalizations.of(context)!.all,
          type: SearchFilterType.all,
          group: SearchFilterTypeState.mode.value,
          onChanged: (type) {
            setState(() {
              seeComics = true;
              seeCollections = true;
              SearchFilterTypeState.mode.value = type;
            });
          },
        ),
        CheckMode(
          label: AppLocalizations.of(context)!.comics,
          type: SearchFilterType.comics,
          group: SearchFilterTypeState.mode.value,
          onChanged: (type) {
            setState(() {
              seeCollections = false;
              seeComics = true;
              SearchFilterTypeState.mode.value = type;
            });
          },
        ),
        CheckMode(
          label: AppLocalizations.of(context)!.collections,
          type: SearchFilterType.collections,
          group: SearchFilterTypeState.mode.value,
          onChanged: (type) {
            setState(() {
              seeComics = false;
              seeCollections = true;
              SearchFilterTypeState.mode.value = type;
            });
          },
        )
      ],
    ),
    );
  }

  Widget _results() {
    return Column(
      spacing: 30,
      children: [
        seeComics ? _comics() : Container(),
        seeCollections ? _collections() : Container()
      ],
    );
  }

  Widget _comics() {
    return StreamBuilder(
      stream: widget.comicManager.search(pattern: _pattern),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: NotFoundComics()
          );
        }
        return ComicsFounded(with_section: true, comics: snapshot.data!);
      }
    );
  }

  Widget _collections() {
    return StreamBuilder(
      stream: widget.collectionManager.search(pattern: _pattern),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: NotFoundComics()
          );
        }
        return CollectionsFounded(with_section: true, collections: snapshot.data!);
      }
    );
  }
}