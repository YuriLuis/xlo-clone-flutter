import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/repositories/anuncio_repository.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store{

  _HomeStore(){
   autorun((_) async{
     try{
       setLoading(true);
       final novosAnuncios = await AnuncioRepository().getHomeAnuncioList(
         filterStore: filterStore,
         search: search,
         category : category,
       );
       anuncioList.clear();
       anuncioList.addAll(novosAnuncios);
       setError(null);
       setLoading(false);
     }catch(e){
       setError(e);
     }
   });
  }

  ObservableList<Anuncio> anuncioList = ObservableList<Anuncio>();

  @observable
  String search = '';

  @observable
  String error = '';

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setError(String value) => error = value;

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