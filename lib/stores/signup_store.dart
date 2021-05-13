import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/model/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store{

  @observable
  String name;

  @observable
  String error;

  @observable
  bool loading = false;

  @observable
  String email;

  @observable
  String phone;

  @observable
  String pass1;

  @observable
  String pass2;

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

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isValidEmail();
  String get emailError {
    if(email == null || emailValid){
      return null;
    }else if(email.isEmpty) {
      return 'Campo Obrigatório';
    }else {
      return 'Email inválido';
    }
  }

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >=14;
  String get phoneError {
    if(phone == null || phoneValid){
      return null;
    }else if(phone.isEmpty) {
      return 'Campo Obrigatório';
    }else {
      return 'Phone inválido';
    }
  }

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => pass1 != null && pass1.isValidPassword();
  String get pass1Error {
    if(pass1 == null || pass1Valid){
      return null;
    }else if(pass1.isEmpty) {
      return 'Campo Obrigatório';
    }else {
      return 'Senha muito curta';
    }
  }

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get pass2Valid => pass2 != null && pass2.isValidPassword() && pass2 == pass1;
  String get pass2Error {
    if(pass2 == null || pass2Valid){
      return null;
    }else {
      return 'Senhas não coincidem';
    }
  }

  @computed
  bool get isFormValid => nameValid && emailValid && phoneValid && pass1Valid && pass2Valid;
  Function get signUpPressed => isFormValid && !loading ? _signUp : null;
  Future<void> _signUp() async{
    loading = true;

    final user = User(
      name: name ,
      email: email,
      phone: phone,
      password: pass1
    );

    try{
      final resultUser = await UserRepository().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
      print(resultUser);
    }catch(e){
      error = e;
    }

    loading = false;
  }


  @action
  void setLoading(bool value) => loading = value;
}
