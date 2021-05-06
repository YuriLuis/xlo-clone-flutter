import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';

class SignUpScreen extends StatelessWidget {
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
          child: Card(
            ///Arredonda o card..
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FieldTitle(title: 'Apelido', subtititle: 'Como aparecerá em seus anúncios.',),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Exempli: João S',
                      isDense: true
                    ),
                  ),
                  SizedBox(height: 16,),
                  FieldTitle(title: 'Email', subtititle: 'Enviaremos um e-mail de confirmação.',),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Exemplo: joao@gmail.com',
                        isDense: true
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                  SizedBox(height: 16,),
                  FieldTitle(title: 'Celular', subtititle: 'Proteja sua conta.',),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '(99) 99999-9999',
                        isDense: true
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                  ),
                  SizedBox(height: 16,),
                  FieldTitle(title: 'Senha', subtititle: 'Use letras, números e caracteres especiais.',),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16,),
                  FieldTitle(title: 'Confirmar Senha', subtititle: 'Repita a senha',),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    obscureText: true,
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    child: RaisedButton(
                      color: Colors.orange,
                      child: Text('CADASTRAR'),
                      textColor: Colors.white,
                      elevation: 0,
                      onPressed: (){},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  Divider(color: Colors.black,),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text('Já tem uma conta? ', style: TextStyle(fontSize: 16),),
                        GestureDetector(
                          onTap: (){
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
                    ),)
                ]
              ),
            ),
          ),
        ),
      )
      ,
    );
  }
}
