import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/lists/collections_founded.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:komik/l10n/app_localizations.dart';
import 'package:komik/service/managers/collection_manager.dart';

class CollectionsPage extends StatefulWidget {
  final CollectionManager collectionManager;

  const CollectionsPage({
    super.key,
    required this.collectionManager
  });

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: StreamBuilder(
          stream: widget.collectionManager.fetch(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _notFounded();
            }

            return CollectionsFounded(with_section: false, collections: snapshot.data!);
          }
        )
      ),
    );
  }

  Widget _notFounded() {
    return Center(
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeroIcon(
            HeroIcons.folder,
            size: 52,
            color: Palette.comic_icon,
            style: HeroIconStyle.solid,
          ),
          BaseText(AppLocalizations.of(context)!.no_collection)
        ],
      ),
    );
  }
}