import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/meus_anuncios/meus_anuncios_screen.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class ContaScreen extends StatelessWidget {
  const ContaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Conta'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.symmetric(horizontal: 32),
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            GetIt.I<UserManagerStore>().user.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.purple,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            GetIt.I<UserManagerStore>().user.email,
                            style:
                                TextStyle(fontSize: 16, color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        textColor: Colors.purple,
                        child: Text('EDITAR'),
                        onPressed: (){},
                      ),
                    )
                  ],
                ),
              ),
              Divider(color: Colors.grey[700],),
              ListTile(
                title: Text('Meus anúncios',
                style: TextStyle(color: Colors.purple,
                fontWeight: FontWeight.w600),),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                  MeusAnunciosScreen()));
                },
              ),
              ListTile(
                title: Text('Favoritos',
                  style: TextStyle(color: Colors.purple,
                      fontWeight: FontWeight.w600),),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){},
              )
            ],
          ),
        ),
      ),
    );
  }
}
