import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

class UserPanel extends StatelessWidget {
  UserPanel(this.anuncio);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 18, bottom: 18),
          child: Text(
            'Anunciante',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                anuncio.user.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10,),
              Text('Na XLO desde ${anuncio.created.formattedDate()}',
              style: TextStyle(color: Colors.grey),)
            ],
          ),
        )
      ],
    );
  }
}
