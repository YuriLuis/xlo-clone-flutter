import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'components/category_field.dart';

class CreateScreen extends StatelessWidget {

  final CreateStore createStore = CreateStore();

  final labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18
  );

  final contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Criar Anúncio'),
        centerTitle: true,
      ),
      body: Card(
        clipBehavior: Clip.antiAlias,
        ///Arredonda o card..
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImagesField(createStore: createStore,),
              TextFormField(
                decoration: InputDecoration(
                    contentPadding: contentPadding,
                    labelText: 'Titulo *',
                    labelStyle: labelStyle
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    contentPadding: contentPadding,
                    labelText: 'Descrição *',
                    labelStyle: labelStyle
                ),
                maxLines: null,
              ),
              CategoryField(createStore: createStore,),
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
                  RealInputFormatter(
                    centavos: true
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
