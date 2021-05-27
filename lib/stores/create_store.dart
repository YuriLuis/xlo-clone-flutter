import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/model/endereco.dart';
import 'package:xlo_mobx/stores/cep_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store{

  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;

  String get imagesError {
    if(imagesValid){
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
    if (titleValid) {
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
    if (descricaoValid) {
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
    if(categoryValid){
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
    if(enderecoValid){
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
    if(precoValid){
      return null;
    }else if(precoText.isEmpty) {
      return 'Campo Obrigatório';
    }else {
      return 'Preço invalido';
    }
  }
}