import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,

        ///adiciona um scrollview no widget.
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              ///Arredonda o card..
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Observer(builder: (_){
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ErrorBox(
                            message : signupStore.error
                          ),
                        );
                      }),
                      FieldTitle(
                        title: 'Apelido',
                        subtititle: 'Como aparecerá em seus anúncios.',
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Exemplo: João S',
                              isDense: true,
                              errorText: signupStore.nomeError),
                          onChanged: signupStore.setName,
                        );
                      }),
                      SizedBox(
                        height: 16,
                      ),
                      FieldTitle(
                        title: 'Email',
                        subtititle: 'Enviaremos um e-mail de confirmação.',
                      ),
                      Observer(
                        builder: (_) {
                          return TextField(
                            enabled: !signupStore.loading,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Exemplo: joao@gmail.com',
                                isDense: true,
                                errorText: signupStore.emailError),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            onChanged: signupStore.setEmail,
                          );
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      FieldTitle(
                        title: 'Celular',
                        subtititle: 'Proteja sua conta.',
                      ),
                      Observer(
                        builder: (_) {
                          return TextField(
                            enabled: !signupStore.loading,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '(99) 99999-9999',
                                isDense: true,
                                errorText: signupStore.phoneError),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter()
                            ],
                            onChanged: signupStore.setPhone,
                          );
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      FieldTitle(
                        title: 'Senha',
                        subtititle:
                            'Use letras, números e caracteres especiais.',
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorText: signupStore.pass1Error),
                          obscureText: true,
                          onChanged: signupStore.setPass1,
                        );
                      }),
                      SizedBox(
                        height: 16,
                      ),
                      FieldTitle(
                        title: 'Confirmar Senha',
                        subtititle: 'Repita a senha',
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorText: signupStore.pass2Error),
                          obscureText: true,
                          onChanged: signupStore.setPass2,
                        );
                      }),
                      Observer(builder: (_) {
                        return Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 20, bottom: 12),
                          child: RaisedButton(
                            disabledColor: Colors.orange.withAlpha(120),
                            color: Colors.orange,
                            child: signupStore.loading ?  CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ): Text('CADASTRAR'),
                            textColor: Colors.white,
                            elevation: 0,
                            onPressed: signupStore.signUpPressed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        );
                      }),
                      Divider(
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              'Já tem uma conta? ',
                              style: TextStyle(fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Entrar',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                    fontSize: 16,
                                  )),
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
