import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:xlo_mobx/model/anuncio.dart';

class DescriptionPanel extends StatelessWidget {

  DescriptionPanel({this.anuncio});

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 18),child: Text(
          'Descrição',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),),
        Padding(padding: EdgeInsets.symmetric(vertical: 18),
          child: ReadMoreText(anuncio.description,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText:  'ver descrição completa',
            trimExpandedText: '...menos',
            colorClickableText: Colors.purple,
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}
