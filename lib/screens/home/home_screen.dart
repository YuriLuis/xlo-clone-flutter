import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';

import 'components/search_dialog.dart';

class HomeScreen extends StatelessWidget {

  _openSearch(BuildContext context) async {
    final search = await showDialog(context: context, builder: (_) => SearchDialog(
      currentSearch: 'Teste',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          actions: [IconButton(onPressed: (){
            _openSearch(context);
          }, icon: Icon(Icons.search))],
        ),
      ),
    );
  }
}
