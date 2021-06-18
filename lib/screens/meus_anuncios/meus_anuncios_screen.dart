import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/meus_anuncios_store.dart';

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
          Container(color: Colors.red,),
          Container(color: Colors.green,),
          Container(color: Colors.yellow,),
        ],
      ),
    );
  }
}
