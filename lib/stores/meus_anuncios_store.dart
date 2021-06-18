import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/repositories/anuncio_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'meus_anuncios_store.g.dart';

class MeusAnunciosStore = _MeusAnunciosStore with _$MeusAnunciosStore;

abstract class _MeusAnunciosStore with Store{

  _MeusAnunciosStore(){
    _getMeusAnuncios();
  }

  Future<void> _getMeusAnuncios() async {

    final user = GetIt.I<UserManagerStore>().user;
    final anuncios = await AnuncioRepository().getMeusAnuncios(user);
    print(anuncios);
  }
}