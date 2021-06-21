import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/model/endereco.dart';
import 'package:xlo_mobx/repositories/anuncio_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store{

  _CreateStore(Anuncio anuncio){
    title = anuncio.title;
    descricao = anuncio.description;
    images = anuncio.images.asObservable();
    category = anuncio.category;
    priceText = anuncio.price?.formattedMoney();
    hidePhone = anuncio.hidePhone;

    if(anuncio != null){
      cepStore = CepStore(anuncio.address.cep);
    }else {
      cepStore = CepStore(null);
    }
  }

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

  CepStore cepStore;

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
  String priceText = '';

  @action
  void setPreco(String value) => priceText = value;

  @computed
  num get price{
    if(priceText.contains(',')){
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    }else {
      return num.tryParse(priceText);
    }
  }

  bool get precoValid => price != null && price <= 9999999;

  String get precoError {
    if(!showErrors || precoValid){
      return null;
    }else if(priceText.isEmpty) {
      return 'Campo Obrigatório';
    }else {
      return 'Preço invalido';
    }
  }

  @computed
  bool get formValid => imagesValid && titleValid && descricaoValid
      && categoryValid && enderecoValid && precoValid;

  Function get sendPressed => formValid ? _send : null;

  @action
  Future<void> _send() async {
    loading = true;
    Anuncio anuncio = createAnuncio();
    try{
      await AnuncioRepository().save(anuncio);
      savedAnuncio = true;
    }catch(e){
      error = e;
    }
    loading = false;
  }

  @observable
  String error = '';

  @observable
  bool showErrors = false;

  @observable
  bool loading = false;

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

  @observable
  bool savedAnuncio = false;

}