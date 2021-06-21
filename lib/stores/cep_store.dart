import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/model/endereco.dart';
import 'package:xlo_mobx/repositories/cep_repository.dart';

part 'cep_store.g.dart';

class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store{

  _CepStore(String initialCep){
    autorun((_){
      if(clearCep.length != 8){
        _resetEndereco();
      }else {
        _searchCep();
      }
    });
    setCep(initialCep);
  }

  ///*Para não dar erro de variavel nulla
  @observable
  String cep = '';

  @observable
  Endereco endereco;

  @observable
  String error;

  @observable
  bool loading = false;
  
  @action
  void setCep(String value) => cep = value;

  @action
  Future<void> _searchCep() async {
    loading = true;
    try {
      endereco = await CepRepository().getEnderecoFromApi(clearCep);
      error = null;

    }catch(e){
      error = e;
      endereco = null;
    }
    loading = false;
  }

  @computed
  String get clearCep => cep.replaceAll(RegExp('[^0-9]'), '');

  void _resetEndereco() {
    endereco = null;
    error = null;
  }
}