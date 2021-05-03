import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/page_tile.dart';

class PageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTile(
          label: 'Anúncios',
          iconData: Icons.list,
          onTap: (){},
          highlighted: true
        ),
        PageTile(
            label: 'Inserir Anúncios',
            iconData: Icons.edit,
            onTap: (){},
            highlighted: false
        ),        PageTile(
            label: 'Chat',
            iconData: Icons.chat,
            onTap: (){},
            highlighted: false
        ),        PageTile(
            label: 'Favoritos',
            iconData: Icons.favorite,
            onTap: (){},
            highlighted: false
        ),        PageTile(
            label: 'Minha Conta',
            iconData: Icons.person,
            onTap: (){},
            highlighted: false
        )
      ],
    );
  }
}
