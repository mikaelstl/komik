import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/icons/logo.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/tool-bars/nav_bar.dart';
import 'package:komik/components/tool-bars/tool_bar.dart';
import 'package:komik/l10n/app_localizations.dart';
import 'package:komik/pages/collection_info.dart';
import 'package:komik/pages/collections_page.dart';
import 'package:komik/pages/comics_page.dart';
import 'package:komik/pages/edit_comic_infos.dart';
import 'package:komik/pages/library_page.dart';
import 'package:komik/pages/reader_page.dart';
import 'package:komik/pages/reading_page.dart';
import 'package:komik/pages/search_page.dart';
import 'package:komik/pages/settings/idioms_page.dart';
import 'package:komik/pages/settings/settings.dart';
import 'package:komik/service/config/user_settings.dart';
import 'package:komik/service/config/user_settings_controller.dart';
import 'package:komik/service/database/database.dart';
import 'package:komik/service/database/models/collection.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/database/models/reading.dart';
import 'package:komik/service/managers/collection_manager.dart';
import 'package:komik/service/managers/comic_manager.dart';
import 'package:komik/service/managers/reading_manager.dart';
import 'package:komik/service/types/root.dart';
import 'package:komik/service/utils/comic_loader.dart';
import 'package:komik/service/utils/file_manager.dart';
import 'package:komik/service/utils/permissions_manager.dart';
import 'package:komik/widgets/accept_storage_permission.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSettings.initInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider<DB>(
          create: (_) => DB(),
          dispose: (_, sp) => sp.close(),
        ),
        Provider<UserSettingsController>(
          create: (_) => UserSettingsController()
        ),
        Provider<FileManager>(
          create: (_) => FileManager()
        )
      ],
      child: const KomikApp(),
    )
  );
}

class KomikApp extends StatefulWidget {
  const KomikApp({super.key});

  @override
  State<KomikApp> createState() => _KomikAppState();
}

class _KomikAppState extends State<KomikApp> {
  final String appName = 'Komik';

  late PermissionsManager permissionManager = PermissionsManager();
  late FileManager fileManager;
  late ComicLoader comicLoader;

  late DB _database;

  late ComicManager comicManager;
  late CollectionManager collectionManager;
  late ReadingManager readingManager;

  late UserSettings userSettings = UserSettings.getInstance();

  final List<Locale> idioms = [
    Locale('en'),
    Locale('pt', 'BR')
  ];

  int index = 0;

  @override
  void dispose() {
    super.dispose();
    _database.close();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserSettingsController(),
      builder: (context, child) {
        final settingsController = Provider.of<UserSettingsController>(context);
        _database = Provider.of<DB>(context);
        
        return MaterialApp(
          locale: Locale(userSettings.language),
          supportedLocales: idioms,
          localizationsDelegates:const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Palette.background,
            appBarTheme: AppBarTheme(backgroundColor: Palette.items),
            primaryTextTheme: GoogleFonts.poppinsTextTheme(),
            textTheme: GoogleFonts.poppinsTextTheme(),
            fontFamily: 'Poppins',
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => _app(context, settingsController),
            '/search': (context) => SearchPage(
              comicManager: comicManager,
              collectionManager: collectionManager,
            ),
            '/collection': (context) => CollectionInfoPage(),
            '/reader': (context) => ReaderPage(
                                      fetchPages: comicLoader.fetchPages,
                                      readingManager: readingManager,
                                    ),
            '/settings': (context) => Settings(),
            '/idioms': (context) => IdiomsPage(idioms),
            '/edit-comic': (context) => EditComicInfos()
          },
        );
      },
    );
  }

  Widget _app(BuildContext context, UserSettingsController controller) {
    return Scaffold(
      appBar: ToolBar(
        leading: Logo(),
      ),
      body: FutureBuilder(
        future: initialize(controller),
        builder: (context, snapshot) {
          return permissionManager.haveStorageAccess
          ? _content(index)
          : AcceptStoragePermission();
        }
      ),
      bottomNavigationBar: NavBar(
        index: index,
        action: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  Widget _content(int index) {
    final pages = {
      0: LibraryPage(
          comicManager: comicManager,
          readingManager: readingManager
        ),
      1: ComicsPage(
        comicManager: comicManager,
      ),
      2: CollectionsPage(
        collectionManager: collectionManager,
      ),
      3: ReadingPage(
        readingManager: readingManager,
      )
    };

    return pages[index]!;
  }

  Future<void> initialize(UserSettingsController controller) async {
    await Root.set();

    await _database.init().then(
      (_) => debugPrint("OBJECT BOX INICIADO")
    );

    await permissionManager.request().then(
      (_) {
        setState(() {
          comicManager = ComicManager(box: _database.store.box<Comic>());
          collectionManager = CollectionManager(box: _database.store.box<Collection>());
          readingManager = ReadingManager(
            box: _database.store.box<Reading>(),
            comic_manager: comicManager
          );
          comicLoader = ComicLoader(
            // decoder: CBZDecoder(decoder: ZipDecoder()),
            comic_manager: comicManager,
            collection_manager: collectionManager
          );
          fileManager = FileManager(
            comic_loader: comicLoader,
            permission_manager: permissionManager,
            settings_controller: controller
          );
        });
      }
    );
    
    await fileManager.createComicsFolder();

    if (comicManager.haveNoData()) {
      unawaited(fileManager.fetch());
    }
  }
}
