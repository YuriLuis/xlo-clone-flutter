import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/meus_anuncios_store.dart';

import 'components/active_tile.dart';
import 'components/pending_tile.dart';
import 'components/sold_tile.dart';

class MeusAnunciosScreen extends StatefulWidget {
  @override
  _MeusAnunciosScreenState createState() => _MeusAnunciosScreenState();
}

class _MeusAnunciosScreenState extends State<MeusAnunciosScreen>
    with SingleTickerProviderStateMixin {

  final MeusAnunciosStore meusAnunciosStore = MeusAnunciosStore();
   TabController tabController;


  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus anúncios'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.orange,
          controller: tabController,
          tabs: [
            Tab(
              child: Text('ATIVOS'),
            ),
            Tab(
              child: Text('PENDENTES'),
            ),
            Tab(
              child: Text('VENDIDOS'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Observer(builder: (_){
            if(meusAnunciosStore.activeAnuncios.isEmpty)
              return Container();
            else
              return ListView.builder(
                itemCount: meusAnunciosStore.activeAnuncios.length,
                itemBuilder: (_, index){
                  return ActiveTile(meusAnunciosStore.activeAnuncios[index]);
                },
              );
          },),
          Observer(builder: (_){
            if(meusAnunciosStore.pendingAnuncios.isEmpty)
              return Container();
            else
              return ListView.builder(
                itemCount: meusAnunciosStore.pendingAnuncios.length,
                itemBuilder: (_, index){
                  return PendingTile(meusAnunciosStore.pendingAnuncios[index]);
                },
              );
          },),
          Observer(builder: (_){
            if(meusAnunciosStore.soldAnuncios.isEmpty)
              return Container();
            else
              return ListView.builder(
                itemCount: meusAnunciosStore.soldAnuncios.length,
                itemBuilder: (_, index){
                  return SoldTile(meusAnunciosStore.soldAnuncios[index]);
                },
              );
          },)
        ],
      ),
    );
  }
}
