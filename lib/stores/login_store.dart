import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email;

  @observable
  String password;

  @observable
  bool loading = false;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isValidEmail();

  String get emailError =>
      email == null || emailValid ? null : 'Email inválido';

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password.length >= 6;

  String get passwordError =>
      password == null || passwordValid ? null : 'Senha inválida';

  @computed
  Function get loginPressed =>
      emailValid && passwordValid && !loading ? _login : null;

  @action
  Future<void> _login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 3));
    loading = false;
  }
}
