import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/model/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class AnuncioRepository {
  Future<List<Anuncio>> getHomeAnuncioList(
      {FilterStore filterStore, String search, Category category}) async {
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyAnuncioTable));
    
    queryBuilder.includeObject([keyAnuncioOwner, keyAnuncioCategory]);
    ///traz sempre de 20 em 20 anuncios.
    queryBuilder.setLimit(20);

    ///Somente anuncios ativos.
    queryBuilder.whereEqualTo(keyAnuncioStatus, AnuncioStatus.ACTIVE.index);
    if (search != null && search.trim().isNotEmpty) {
      queryBuilder.whereContains(keyAnuncioTitle, search, caseSensitive: false);
    }

    // ignore: unrelated_type_equality_checks
    if (category != null && category != '*') {
      queryBuilder.whereEqualTo(
          keyAnuncioCategory,
          (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
              .toPointer());
    }

    switch (filterStore.orderBy) {
      case OrderBy.PRICE:
        queryBuilder.orderByAscending(keyAnuncioPrice);
        break;
      case OrderBy.DATE:
        queryBuilder.orderByDescending(keyAnuncioCreatedAt);
        break;
      default:
        queryBuilder.orderByDescending(keyAnuncioCreatedAt);
        break;
    }

    if (filterStore.minPrice != null && filterStore.minPrice > 0) {
      queryBuilder.whereGreaterThanOrEqualsTo(
          keyAnuncioPrice, filterStore.minPrice);
    }

    if (filterStore.maxPrice != null && filterStore.maxPrice > 0) {
      queryBuilder.whereLessThanOrEqualTo(
          keyAnuncioPrice, filterStore.maxPrice);
    }

    final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());
    if (filterStore.isTypeParticular) {
      userQuery.whereEqualTo(keyUserType, UserType.PARTICULAR.index);
    }
    if (filterStore.isTypeProfissional) {
      userQuery.whereEqualTo(keyUserType, UserType.PROFISSIONAL.index);
    }

    queryBuilder.whereMatchesQuery(keyAnuncioOwner, userQuery);

    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results
          .map((parseObject) => Anuncio.fromParse(parseObject))
          .toList();
    }else if(response.success && response.results == null){
      return [];
    }else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> save(Anuncio anuncio) async {
    try {
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
      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
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
