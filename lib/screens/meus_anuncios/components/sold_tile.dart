import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

class SoldTile extends StatelessWidget {

  SoldTile(this.anuncio);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Container(
        height: 80,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: anuncio.images.isEmpty
                    ? 'https://static.thenounproject.com/png/194055-200.png'
                    : anuncio.images.first,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        anuncio.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        anuncio.price.formattedMoney(),
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                )),
            Column(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.delete,
                color: Colors.purple,size: 20,))
              ],
            )
          ],
        ),
      ),
    );;
  }
}
