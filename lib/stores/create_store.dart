import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/model/category.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store{

  ObservableList images = ObservableList();

  @observable
  bool hidePhone = false;

  @observable
  Category category;

  @observable
  String title = '';

  @observable
  String descricao = '';

  @action
  void setCategory(Category value) => category = value;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  @action
  void setTitle(String value) => title = value;

  @action
  void setDescricao(String value) => descricao = value;

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError {
    if(imagesValid){
      return null;
    }else {
      return 'Insira uma imagem!';
    }
  }

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
}