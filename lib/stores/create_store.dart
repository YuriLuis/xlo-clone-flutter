import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/model/endereco.dart';
import 'package:xlo_mobx/repositories/anuncio_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store{

  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;

  String get imagesError {
    if(!showErrors || imagesValid){
      return null;
    }else {
      return 'Insira uma imagem!';
    }
  }

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >6;
  String get titleError {
    if (!showErrors || titleValid) {
      return null;
    } else if (title.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Titulo muito curto';
    }
  }

  @observable
  String descricao = '';

  @action
  void setDescricao(String value) => descricao = value;

  @computed
  bool get descricaoValid => descricao.length >=10;
  String get descricaoError {
    if (!showErrors || descricaoValid) {
      return null;
    } else if (descricao.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Descrição muito curto';
    }
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String get categoryError {
    if(!showErrors || categoryValid){
      return null;
    }else {
      return 'Campo Obrigatório!';
    }
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  CepStore cepStore = CepStore();

  @computed
  Endereco get endereco => cepStore.endereco;

  bool get enderecoValid => endereco != null;

  String get enderecoError{
    if(!showErrors || enderecoValid){
      return null;
    }else {
      return 'Campo Obrigatório';
    }
  }

  @observable
  String precoText = '';

  @action
  void setPreco(String value) => precoText = value;

  @computed
  num get price{
    if(precoText.contains(',')){
      return num.tryParse(precoText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    }else {
      return num.tryParse(precoText);
    }
  }

  bool get precoValid => price != null && price <= 9999999;

  String get precoError {
    if(!showErrors || precoValid){
      return null;
    }else if(precoText.isEmpty) {
      return 'Campo Obrigatório';
    }else {
      return 'Preço invalido';
    }
  }

  @computed
  bool get formValid => imagesValid && titleValid && descricaoValid
      && categoryValid && enderecoValid && precoValid;

  Function get sendPressed => formValid ? _send : null;

  void _send(){
    Anuncio anuncio = createAnuncio();
    AnuncioRepository().save(anuncio);
  }

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  Anuncio createAnuncio(){
    final a = Anuncio();
    a.title = title;
    a.description = descricao;
    a.category = category;
    a.price = price;
    a.hidePhone = hidePhone;
    a.images = images;
    a.address = endereco;
    a.user = GetIt.I<UserManagerStore>().user;
    return a;
  }
}