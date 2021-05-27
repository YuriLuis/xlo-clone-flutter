import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/model/endereco.dart';
import 'package:xlo_mobx/model/user.dart';

enum AnuncioStatus{PEDING, ACTIVE, SOLD, DELETED}

class Anuncio {

  String id;
  List images;
  String title;
  String description;
  Category category;
  Endereco address;
  num price;
  bool hidePhone;
  AnuncioStatus status = AnuncioStatus.PEDING;
  DateTime created;
  User user;
  int views;
}