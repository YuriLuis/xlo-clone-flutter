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

  @action
  void setCategory(Category value) => category = value;

  @action
  void setHidePhone(bool value) => hidePhone = value;
}