import 'dart:typed_data';

import 'package:komik/service/database/models/collection.dart';
import 'package:komik/service/utils/interfaces/create_dto.dart';

interface class CreateComicDTO implements CreateDTO {
  late String title;
  late String subtitle;
  late String edition;
  late Uint8List thumb;
  late String path;
  Collection? collection;
}