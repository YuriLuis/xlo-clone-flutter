import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  final CreateStore createStore = CreateStore();


  @override
  void initState() {
    super.initState();
    ///When não precisa dar dispose!
    when((_) => createStore.savedAnuncio, (){
      GetIt.I<PageStore>().setPage(0);
    });
  }

  final labelStyle =
      TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18);

  final contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Criar Anúncio'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Card(
          clipBehavior: Clip.antiAlias,

          ///Arredonda o card..
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: SingleChildScrollView(
            child: Observer(
              builder: (_) {
                if (createStore.loading) {
                  return Padding(padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Salvando Anúncio',style: TextStyle(
                        fontSize: 18, color: Colors.purple
                      ),),
                      SizedBox(height: 16,),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.purple),
                      )
                    ],
                  ),);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImagesField(
                        createStore: createStore,
                      ),
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            onChanged: createStore.setTitle,
                            decoration: InputDecoration(
                                contentPadding: contentPadding,
                                labelText: 'Titulo *',
                                labelStyle: labelStyle,
                                errorText: createStore.titleError),
                          );
                        },
                      ),
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            onChanged: createStore.setDescricao,
                            decoration: InputDecoration(
                                contentPadding: contentPadding,
                                labelText: 'Descrição *',
                                labelStyle: labelStyle,
                                errorText: createStore.descricaoError),
                            maxLines: null,
                          );
                        },
                      ),
                      CategoryField(
                        createStore: createStore,
                      ),
                      CepField(createStore),
                      Observer(builder: (_) {
                        return TextFormField(
                          onChanged: createStore.setPreco,
                          decoration: InputDecoration(
                              contentPadding: contentPadding,
                              labelText: 'Preço *',
                              labelStyle: labelStyle,
                              prefixText: 'R\$ ',
                              errorText: createStore.precoError),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            RealInputFormatter(centavos: true)
                          ],
                        );
                      }),
                      HidePhoneField(createStore),
                      Observer(builder: (_){
                        return ErrorBox(message: createStore.error,);
                      },),
                      Observer(builder: (_) {
                        return SizedBox(
                          height: 50,
                          child: GestureDetector(
                            onTap: createStore.invalidSendPressed,
                            child: RaisedButton(
                              child: Text(
                                'Criar',
                                style: TextStyle(fontSize: 25),
                              ),
                              textColor: Colors.white,
                              color: Colors.orange,
                              disabledColor: Colors.orange.withAlpha(120),
                              onPressed: createStore.sendPressed,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        );
                      })
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
