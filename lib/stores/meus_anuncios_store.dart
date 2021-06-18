import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:xlo_mobx/repositories/anuncio_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'meus_anuncios_store.g.dart';

class MeusAnunciosStore = _MeusAnunciosStore with _$MeusAnunciosStore;

abstract class _MeusAnunciosStore with Store{

  _MeusAnunciosStore(){
    _getMeusAnuncios();
  }

  Future<void> _getMeusAnuncios() async {
    try{
      final user = GetIt.I<UserManagerStore>().user;
      allAnuncios = await AnuncioRepository().getMeusAnuncios(user);
    }catch(e){
    }
  }

  @observable
  List<Anuncio> allAnuncios = [];
  
  @computed
  List<Anuncio> get activeAnuncios => allAnuncios.where((anuncio) =>
  anuncio.status == AnuncioStatus.ACTIVE).toList();
  List<Anuncio> get pendingAnuncios => allAnuncios.where((anuncio) =>
  anuncio.status == AnuncioStatus.PEDING).toList();
  List<Anuncio> get soldAnuncios => allAnuncios.where((anuncio) =>
  anuncio.status == AnuncioStatus.SOLD).toList();
}