import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/model/cidade.dart';
import 'package:xlo_mobx/model/endereco.dart';
import 'package:xlo_mobx/model/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

import 'estado.dart';

enum AnuncioStatus { PEDING, ACTIVE, SOLD, DELETED }

class Anuncio {

  Anuncio();

  Anuncio.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    title = parseObject.get<String>(keyAnuncioTitle);
    description = parseObject.get<String>(keyAnuncioDescription);
    images = parseObject.get<List>(keyAnuncioImages).map((e) => e.url).toList();
    hidePhone = parseObject.get<bool>(keyAnuncioHidePhone);
    price = parseObject.get<num>(keyAnuncioPrice);
    created = parseObject.createdAt;
    address = Endereco(
      bairro: parseObject.get<String>(keyAnuncioDistrict),
      cidade: Cidade(nome: parseObject.get<String>(keyAnuncioCity)),
      cep: parseObject.get<String>(keyAnuncioPostalCode),
      estado: Estado(sigla: parseObject.get(keyAnuncioFederativeUnit)),
    );
    views = parseObject.get<int>(keyAnuncioViews, defaultValue: 0);
    user = UserRepository().mapParseToUser(parseObject.get(keyAnuncioOwner));
    category =
        Category.fromParse(parseObject.get<ParseObject>(keyAnuncioCategory));
    status = AnuncioStatus.values[parseObject.get<int>(keyAnuncioStatus)];
  }

  String id;
  List images = [];
  String title;
  String description;
  Category category;
  Endereco address;
  num price;
  bool hidePhone= false;
  AnuncioStatus status = AnuncioStatus.PEDING;
  DateTime created;
  User user;
  int views;
}
