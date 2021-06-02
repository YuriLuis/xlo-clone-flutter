import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class AnuncioRepository {
  Future<void> save(Anuncio anuncio) async {

    try{
      final parseImages = await _saveImages(anuncio.images);

      final parseUser = ParseUser('', '', '')..set(keyUserId, anuncio.user.id);

      final anuncioObject = ParseObject(keyAnuncioTable);

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      anuncioObject.setACL(parseAcl);

      _setDataInAnuncio(anuncioObject, anuncio, parseImages, parseUser);

      ///Salva no parse!
      final response = await anuncioObject.save();
      if(!response.success){
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    }catch(e){
      return Future.error('Falha ao salvar anúncio');
    }

  }

  void _setDataInAnuncio(ParseObject parseObject, Anuncio anuncio,
      List<ParseFile> listImagensParse, ParseUser parseUser) {
    parseObject.set<String>(keyAnuncioTitle, anuncio.title);
    parseObject.set<String>(keyAnuncioDescription, anuncio.description);
    parseObject.set<bool>(keyAnuncioHidePhone, anuncio.hidePhone);
    parseObject.set<num>(keyAnuncioPrice, anuncio.price);
    parseObject.set<int>(keyAnuncioStatus, anuncio.status.index);
    parseObject.set<String>(keyAnuncioDistrict, anuncio.address.bairro);
    parseObject.set<String>(keyAnuncioCity, anuncio.address.cidade.nome);
    parseObject.set<String>(
        keyAnuncioFederativeUnit, anuncio.address.estado.sigla);
    parseObject.set<String>(keyAnuncioPostalCode, anuncio.address.cep);
    parseObject.set<List<ParseFile>>(keyAnuncioImages, listImagensParse);
    parseObject.set<ParseUser>(keyAnuncioOwner, parseUser);
    parseObject.set<ParseObject>(keyAnuncioCategory,
        ParseObject(keyCategoryTable)..set(keyCategoryId, anuncio.category.id));
  }

  // ignore: missing_return
  Future<List<ParseFile>> _saveImages(List images) async {
    final parseImages = <ParseFile>[];
    try {
      for (var image in images) {
        if (_isFile(image)) {
          final parseFile = ParseFile(image, name: path.basename(image.path));

          final response = await parseFile.save();

          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error.code));
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
    } catch (e) {
      Future.error('Falha ao salvar imagem!');
    }
  }

  bool _isFile(dynamic image) {
    return image is File;
  }
}
