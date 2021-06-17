import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/model/anuncio.dart';

import 'components/main_panel.dart';

class AnuncioScreen extends StatelessWidget {
  AnuncioScreen(this.anuncio);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Anuncio'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _imagensAnuncio(),
          _detalhesAnuncio()
        ],
      ),
    );
  }

  Widget _imagensAnuncio() {
    return Container(
      height: 280,
      child: Carousel(
        images: anuncio.images
            .map((imagemUrl) => CachedNetworkImageProvider(imagemUrl))
            .toList(),
        dotSize: 4,
        dotBgColor: Colors.transparent,
        dotColor: Colors.orange,
        autoplay: false,
      ),
    );
  }

  Widget _detalhesAnuncio(){
    return Padding(padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainPanel(anuncio),
        Divider(color: Colors.grey[500],)
      ],
    ),);
  }
}
