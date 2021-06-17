import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

class MainPanel extends StatelessWidget {
  MainPanel(this.anuncio);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24, bottom: 14),
          child: Text(
            anuncio.price.formattedMoney(),
            style: TextStyle(
              fontSize: 34,
              letterSpacing: 2.8,
              fontWeight: FontWeight.w300,
              color: Colors.grey[800],
            ),
          ),
        ),
        Text(
          anuncio.title,
          style: TextStyle(
              fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w400),
        ),
        Padding(padding: EdgeInsets.only(top: 20, bottom: 18),
        child: Text('Publicado em ${anuncio.created.formattedDate()}',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey[600],
        ),),)
      ],
    );
  }
}
