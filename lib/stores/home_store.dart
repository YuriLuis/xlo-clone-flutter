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
         page: page
       );
       addNovoAnuncio(novosAnuncios);
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

  @observable
  int page = 0;

  @action
  void loadNextPage(){
    page++;
  }
  @action
  void setLoading(bool value) => loading = value;

  @action
  void setError(String value) => error = value;

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filterStore = FilterStore();

  FilterStore get clonedFilter => filterStore.clone();

  @action
  void setFilter(FilterStore value) {
    filterStore = value;
    resetPage();
  }

  @action
  void addNovoAnuncio(List<Anuncio> listAnuncios){
    if(listAnuncios.length < 10){
      lastPage = true;
    }
    anuncioList.addAll(listAnuncios);
  }

  @observable
  bool lastPage = false;

  void resetPage(){
    page = 0;
    anuncioList.clear();
    lastPage = false;
  }

  @computed
  int get itemCount => lastPage ? anuncioList.length : anuncioList.length +1;
  bool get showProgress => loading && anuncioList.isEmpty;

}