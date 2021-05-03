import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/home/home_screen.dart';

class BaseScreen extends StatelessWidget {

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Pageview para gerenciar as telas, facilita com o Navigation Drawer!
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          Container(color: Colors.green,),
          Container(color: Colors.yellow),
          Container(color: Colors.purple),
          Container(color: Colors.brown),
        ],
      ),
    );
  }
}
