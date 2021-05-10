import 'package:mobx/mobx.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store{

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length > 6;
  String get nomeError {
    if(name == null || nameValid){
      return null;
    }else if(name.isEmpty) {
      return 'Campo Obrigatório';
    }else {
      return 'Nome muito curto';
    }
  }

}