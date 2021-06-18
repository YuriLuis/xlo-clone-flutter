import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/model/anuncio.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile(this.anuncio);

  final Anuncio anuncio;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 0, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 0, title: 'Excluir', iconData: Icons.delete),
  ];

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
              width: 8,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  Text(
                    '${anuncio.views} visitas',
                    style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                  ),
                ],
              ),
            )),
            Column(
              children: [
                PopupMenuButton<MenuChoice>(
                    onSelected: (choice){
                      switch(choice.index){
                        case 0 :
                          break;
                        case 1:
                          break;
                        case 2:
                          break;
                      }
                    },
                    itemBuilder: (_) {
                  return choices
                      .map(
                        (choice) => PopupMenuItem<MenuChoice>(
                          value: choice,
                          child: Row(
                            children: [
                              Icon(
                                choice.iconData,
                                size: 20,
                                color: Colors.purple,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                choice.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.purple),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList();
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MenuChoice {
  MenuChoice({this.index, this.title, this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
