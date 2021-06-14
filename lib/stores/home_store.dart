import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/repositories/anuncio_repository.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store{

  _HomeStore(){
   autorun((_) async{
     final novosAnuncios = await AnuncioRepository().getHomeAnuncioList(
       filterStore: filterStore,
       search: search,
       category : category,
     );
     print(novosAnuncios);
   });
  }
  @observable
  String search = '';

  @action
  void setSearch(String value) => search = value;

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @observable
  FilterStore filterStore = FilterStore();

  FilterStore get clonedFilter => filterStore.clone();

  @action
  void setFilter(FilterStore value) => filterStore = value;

}