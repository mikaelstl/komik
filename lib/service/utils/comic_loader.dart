import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:flutter/widgets.dart';
import 'package:komik/service/database/models/collection.dart';
import 'package:komik/service/dto/create_comic.dart';
import 'package:komik/service/managers/collection_manager.dart';
import 'package:komik/service/managers/comic_manager.dart';
import 'package:komik/service/utils/cbz_decoder.dart';
import 'package:komik/service/utils/interfaces/file_decorder.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

class ComicLoader {
  final FileDecoder _decoder = CBZDecoder(decoder: ZipDecoder());
  
  late ComicManager _comicManager;

  late CollectionManager _collectionManager;

  ComicLoader({
    required ComicManager comic_manager,
    required CollectionManager collection_manager
  }) {
    _comicManager = comic_manager;
    _collectionManager = collection_manager;
  }
  
  void load(File file) {
    try {
      final data = fetchInfos(file.path);
      
      Collection collection = _collectionManager.find(pattern: data.title) ?? _collectionManager.create(
        title: data.title,
        description: ''
      );

      data.collection = _collectionManager.get(id: collection.id);
      
      _comicManager.create(data: data);
    } catch (err) {
      throw Exception(err);
    }
  }

  CreateComicDTO fetchInfos(String filePath) {
    final title = path.basename(filePath).replaceAll('.cbz', '').split('#');
    final values = title[1].split('-');

    final infos = CreateComicDTO();
      infos.title = title[0];
      infos.subtitle = values[values.length - 1]!=values[0] ? values[values.length - 1] : '';
      infos.edition = values[0];
      infos.thumb = fetchThumb(filePath);
      infos.path = filePath;

    return infos;
  }

  Uint8List fetchThumb(String filePath) {
    try {
      final archives = _decoder.decode(filePath);
      
      final bytes = archives.where((archive) =>  isImage(archive.name) && isThumb(archive.name)).first.content;

      img.Image? image = img.decodeJpg(bytes);

      return image != null ? Uint8List.fromList(img.encodeJpg(image, quality: 10)) : Uint8List(0);
    } on PathNotFoundException {
      final extension = path.extension(filePath);
      final fileName = path.basename(filePath).replaceAll(extension, '');

      debugPrint('$fileName >>> ARQUIVO NÃO SUPORTADO');

      return Uint8List(0);
    } on StateError {
      final extension = path.extension(filePath);
      final fileName = path.basename(filePath).replaceAll(extension, '');

      debugPrint('$fileName >>> ARQUIVO CORROMPIDO');

      return Uint8List(0);
    }
  }

  bool isImage(String name) {
    if (
      name.endsWith('.png') ||
      name.endsWith('.jpg') ||
      name.endsWith('.jpeg')
    ) {
      return true;
    } else {
      return false;
    }
  }

  bool isThumb(String name) {
    if (
      name.contains('01') ||
      name.contains('00')
    ) {
      return true;
    } else {
      return false;
    }
  }

  List<Uint8List> fetchPages(String filePath) {
    final archives = _decoder
                      .decode(filePath)
                      .files;
    try {
      return archives.where((archive) => isImage(archive.name))
                   .map((archive) => archive.content)
                   .toList();
    } catch (e) {
      final extension = path.extension(filePath);
      final fileName = path.basename(filePath).replaceAll(extension, '');
      debugPrint('$fileName >>> ARQUIVO NÃO SUPORTADO');
      return [];
    }
  }
}