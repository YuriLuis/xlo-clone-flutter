import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import 'components/search_dialog.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  _openSearch(BuildContext context) async {
    final search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(
              currentSearch: homeStore.search,
            ));
    if (search != null) {
      homeStore.setSearch(search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Observer(
            builder: (_) {
              if (homeStore.search.isEmpty) {
                return Container();
              } else {
                return GestureDetector(
                  onTap: () => _openSearch(context),
                    child: LayoutBuilder(
                      builder: (_, constraints){
                        return Container(
                          width: constraints.biggest.width,
                          child: Text(homeStore.search));
                      },
                    ));
              }
            },
          ),
          actions: [
            Observer(
              builder: (_){
                if(homeStore.search.isEmpty){
                  return IconButton(
                      onPressed: () {
                        _openSearch(context);
                      },
                      icon: Icon(Icons.search));
                }else {
                  return IconButton(
                    onPressed: (){
                      homeStore.setSearch('');
                    },
                    icon: Icon(Icons.close),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
