import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/repositories/parse_errors.dart';

class AnuncioRepository {
  Future<void> save(Anuncio a) async {
    final parseImages = await _saveImages(a.images);
  }

  Future<List<ParseFile>> _saveImages(List images) async {
    final parseImages = <ParseFile>[];

    try{
      for (var image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(ParseErrors.getDescription(response.error.code));
          }
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    }catch(e){
      Future.error('Falha ao salvar imagem!');
    }

  }
}
