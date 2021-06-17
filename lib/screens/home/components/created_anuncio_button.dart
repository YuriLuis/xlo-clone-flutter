import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class CreatedAnuncioButton extends StatefulWidget {

  CreatedAnuncioButton(this.scrollController);

  final ScrollController scrollController;

  @override
  _CreatedAnuncioButtonState createState() => _CreatedAnuncioButtonState();
}

class _CreatedAnuncioButtonState extends State<CreatedAnuncioButton> with
SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> buttonAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: buttonAnimation,
        builder: (_, __){
          return FractionallySizedBox(
            widthFactor: 0.6,
            child: Container(
              height: 50,
              margin: EdgeInsets.only(bottom: buttonAnimation.value),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                color: Colors.orange,
                textColor: Colors.white,
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(child: Text('Anunciar agora',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),))
                  ],
                ),
                onPressed: (){
                  GetIt.I<PageStore>().setPage(1);
                },
              ),
            ),
          );
        });
  }
  
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));

    buttonAnimation = Tween<double>(begin: 0 , end: 66).animate(
      CurvedAnimation(parent: controller, curve: Interval(
        0.4 , 0.6
      ))
    );

    widget.scrollController.addListener(scrollChanged);
  }

  void scrollChanged(){
    final s = widget.scrollController.position;
    if(s.userScrollDirection == ScrollDirection.forward){
      controller.forward();
    }else {
      controller.reverse();
    }
  }
}
