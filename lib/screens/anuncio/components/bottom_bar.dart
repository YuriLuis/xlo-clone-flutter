import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xlo_mobx/model/anuncio.dart';

class BottomBar extends StatelessWidget {
  BottomBar(this.anuncio);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    if(anuncio.status == AnuncioStatus.PEDING)
      return Container();
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 26),
            height: 38,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19), color: Colors.orange),
            child: Row(
              children: [
                if(!anuncio.hidePhone)
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      final phone = anuncio.user.phone.replaceAll(RegExp('[^0-9]'), '');
                      launch('tel: ${phone}');
                    },
                    child: Container(
                      height: 25,
                      decoration: BoxDecoration(
                          border:
                              Border(right: BorderSide(color: Colors.black45))),
                      alignment: Alignment.center,
                      child: Text('Ligar',
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15)),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){},
                    child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      child: Text('Chat',
                      style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(249, 249, 249, 1),
                border: Border(
                  top: BorderSide(color: Colors.grey[400]),
                )),
            height: 38,
            alignment: Alignment.center,
            child: Text(
              '${anuncio.user.name} (anunciante)',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
