import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/screens/anuncio/anuncio_screen.dart';

class PendingTile extends StatelessWidget {
  PendingTile(this.anuncio);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> AnuncioScreen(anuncio)));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        child: Container(
          height: 80,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: CachedNetworkImage(
                  imageUrl: anuncio.images.isEmpty
                      ? 'https://static.thenounproject.com/png/194055-200.png'
                      : anuncio.images[0],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.orange,
                            size: 15,
                          ),
                          SizedBox(width: 4,),
                          Text(
                            'AGUARDANDO PUBLICAÇÃO',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          )

                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
