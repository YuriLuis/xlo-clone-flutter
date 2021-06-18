import 'package:flutter/material.dart';
import 'package:xlo_mobx/model/anuncio.dart';

class LocalizacaoPanel extends StatelessWidget {

  LocalizacaoPanel(this.anuncio);

  final Anuncio anuncio;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 18, bottom: 12),child: Text(
          'Localização',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),),
        Row(
          children: [
            Expanded(child: Column(
              children: [
                Text('CEP'),
                SizedBox(height: 12,),
                Text('Município'),
                SizedBox(
                  height: 12,
                ),
                Text('Bairro'),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )),
            Expanded(child: Padding(padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('${anuncio.address.cep}'),
                SizedBox(
                  height: 12,
                ),
                Text('${anuncio.address.cidade.nome}'),
                SizedBox(
                  height: 12,
                ),
                Text('${anuncio.address.bairro}')
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),))
          ],
        ),
      ],
    );
  }
}
