import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/repositories/category_repository.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store{

  _CategoryStore(){
    _loadCategories();
  }

  ObservableList<Category> categoryList = ObservableList<Category>();

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @action
  void setCategories(List<Category> categories){
    categoryList.clear();
    categoryList.addAll(categories);
  }

  Future<void> _loadCategories() async {
    try{
      final List<Category> categories = await CategoryRepository().getListCategory();
      setCategories(categories);
    }catch(e){
      setError(e.toString());
    }
  }

  @computed
  List<Category> get allCategoryList => List.from(categoryList)
      ..insert(0, Category(id: '*', description: 'Todas'));
}