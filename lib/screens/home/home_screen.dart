import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import 'components/anuncio_tile.dart';
import 'components/created_anuncio_button.dart';
import 'components/search_dialog.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  final ScrollController scrollController = ScrollController();

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
                      builder: (_, constraints) {
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
              builder: (_) {
                if (homeStore.search.isEmpty) {
                  return IconButton(
                      onPressed: () {
                        _openSearch(context);
                      },
                      icon: Icon(Icons.search));
                } else {
                  return IconButton(
                    onPressed: () {
                      homeStore.setSearch('');
                    },
                    icon: Icon(Icons.close),
                  );
                }
              },
            )
          ],
        ),
        body: Column(
          children: [
            TopBar(),
            Expanded(
              child: Stack(
                children: [
                  Observer(
                    builder: (_) {
                      if (homeStore.error != null) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                color: Colors.white,
                                size: 100,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Ocorreu um erro!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        );
                      } else {
                        if (homeStore.showProgress) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          );
                        }

                        if (homeStore.anuncioList.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.border_all,
                                  color: Colors.white,
                                  size: 100,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Nenhum anúncio encontrado!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: homeStore.itemCount,
                          itemBuilder: (_, index) {
                            if(index < homeStore.anuncioList.length)
                              return AnuncioTile(
                                anuncio: homeStore.anuncioList[index],
                              );

                            homeStore.loadNextPage();
                            return Container(
                              height: 10,
                              child: LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.purple),
                              ),
                            );

                          },
                        );
                      }
                    },
                  ),
                  Positioned(
                    bottom: -50,
                    left:  0,
                    right: 0,
                    child: CreatedAnuncioButton(
                        scrollController
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
