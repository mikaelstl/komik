import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/icons/logo.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/tool-bars/tool_bar.dart';
import 'package:komik/pages/collection_info.dart';
import 'package:komik/pages/collections_page.dart';
import 'package:komik/pages/comics_page.dart';
import 'package:komik/pages/edit_comic_infos.dart';
import 'package:komik/pages/library_page.dart';
import 'package:komik/pages/reader_page.dart';
import 'package:komik/pages/reading_page.dart';
import 'package:komik/pages/search_page.dart';
import 'package:komik/pages/settings/local_files_page.dart';
import 'package:komik/pages/settings/settings.dart';
import 'package:komik/service/database/database.dart';
import 'package:komik/service/database/models/collection.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/database/models/reading.dart';
import 'package:komik/service/managers/collection_manager.dart';
import 'package:komik/service/managers/comic_manager.dart';
import 'package:komik/service/managers/reading_manager.dart';
// import 'package:komik/service/database/models/comic.dart';
// import 'package:komik/service/models/comic.dart';
import 'package:komik/service/utils/comic_loader.dart';
import 'package:komik/service/utils/file_manager.dart';
import 'package:komik/service/utils/permissions_manager.dart';
import 'package:komik/widgets/accept_storage_permission.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const KomikApp());
}

class KomikApp extends StatefulWidget {
  const KomikApp({super.key});

  @override
  State<KomikApp> createState() => _KomikAppState();
}

class _KomikAppState extends State<KomikApp> {
  final String appName = 'Komik';

  final _database = DB();

  late PermissionsManager permissionManager = PermissionsManager();
  late FileManager fileManager;
  late ComicLoader comicLoader;

  late ComicManager comicManager;
  late CollectionManager collectionManager;
  late ReadingManager readingManager;

  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _database.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Palette.background,
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),
        textTheme: GoogleFonts.poppinsTextTheme(),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => _app(),
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
        '/local-files': (context) => LocalFilesPage(),
        '/edit-comic': (context) => EditComicInfos()
      },
    );
  }

  Widget _app() {
    return Scaffold(
      appBar: ToolBar(
        leading: Logo(),
      ),
      body: FutureBuilder(
        future: initialize(),
        builder: (context, snapshot) {
          return permissionManager.haveStorageAccess
          ? _content(index)
          : AcceptStoragePermission();
        }
      ),
      bottomNavigationBar: _navBar(),
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

  Widget _navBar() {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Palette.details, width: 2))),
      child: NavigationBarTheme(
          data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.all(TextStyle(
            color: Palette.white,
            fontSize: 12,
          ))),
          child: NavigationBar(
            onDestinationSelected: (value) {
              setState(() {
                index = value;
              });
            },
            destinations: [
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.home,
                  style: HeroIconStyle.solid,
                  size: 24,
                  color: Palette.white,
                ),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.bookOpen,
                  style: HeroIconStyle.solid,
                  size: 24,
                  color: Palette.white,
                ),
                label: 'Quadrinhos',
              ),
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.wallet,
                  style: HeroIconStyle.solid,
                  size: 24,
                  color: Palette.white,
                ),
                label: 'Coleções',
              ),
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.bookmarkSquare,
                  style: HeroIconStyle.solid,
                  size: 24,
                  color: Palette.white,
                ),
                label: 'Lendo',
              ),
            ],
            selectedIndex: index,
            backgroundColor: Palette.items,
            indicatorColor: const Color.fromARGB(83, 228, 25, 59),
          )),
    );
  }

  Future<void> initialize() async {
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
            permission_manager: permissionManager
          );
        });  
      }
    );
    
    await fileManager.createComicsFolder();

    if (comicManager.haveNoData()) {
      fileManager.fetch();
    }
  }
}
