import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/model/anuncio.dart';

class AnuncioTile extends StatelessWidget {
  AnuncioTile({this.anuncio});

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      height: 135,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            SizedBox(
              height: 135,
              width: 127,
              child: CachedNetworkImage(
                imageUrl: anuncio.images.isEmpty
                    ? 'https://static.thenounproject.com/png/194055-200.png'
                    : anuncio.images.first,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(anuncio.title,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                      Text('R\$: ${anuncio.price.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
                      Text(
                        '${anuncio.created} - '
                        '${anuncio.address.cidade.nome} - '
                        '${anuncio.address.estado.sigla}',
                         style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
              ],
            ),
                ))
          ],
        ),
      ),
    );
  }
}
