import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';

class CreateScreen extends StatelessWidget {
  final CreateStore createStore = CreateStore();

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
            child: Column(
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
                          labelStyle: labelStyle ,
                      errorText: createStore.descricaoError),
                      maxLines: null,
                    );
                  },
                ),
                CategoryField(
                  createStore: createStore,
                ),
                CepField(),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: contentPadding,
                    labelText: 'Preço *',
                    labelStyle: labelStyle,
                    prefixText: 'R\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    RealInputFormatter(centavos: true)
                  ],
                ),
                HidePhoneField(createStore),
                SizedBox(
                  height: 50,
                  child: RaisedButton(
                    child: Text(
                      'Criar',
                      style: TextStyle(fontSize: 25),
                    ),
                    textColor: Colors.white,
                    color: Colors.orange,
                    disabledColor: Colors.orange.withAlpha(120),
                    onPressed: () {},
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
