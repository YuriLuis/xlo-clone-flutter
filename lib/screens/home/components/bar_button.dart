import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {

  BarButton({this.boxDecoration, this.label, this.onTap});

  final _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600
  );

  final BoxDecoration boxDecoration;

  final String label;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (){},
        child: Container(
          decoration: boxDecoration,
          alignment: Alignment.center,
          height: 40,
          child: Text(label,
          style: _textStyle,),
        ),
      ),
    );
  }
}
