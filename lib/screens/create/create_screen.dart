import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';

class CreateScreen extends StatelessWidget {

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
        ///Arredonda o card..
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: [
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
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: contentPadding,
                  labelText: 'Categoria *',
                  labelStyle: labelStyle
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: contentPadding,
                  labelText: 'CEP *',
                  labelStyle: labelStyle
              ),
            ),
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
    );
  }
}
