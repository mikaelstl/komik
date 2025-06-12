import 'dart:typed_data';

import 'package:komik/service/database/models/collection.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Comic {
  @Id()
  int id = 0;
  
  late String        title;
  late String        subtitle = '';
  late String        edition;
  late Uint8List     thumb;
  late String        path;
  late bool          reading = false;

  final collection = ToOne<Collection>();

  Comic({
    required this.title,
    required this.subtitle,
    required this.thumb,
    required this.edition,
    required this.path
  });

}