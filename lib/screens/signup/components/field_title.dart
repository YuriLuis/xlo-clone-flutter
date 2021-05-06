import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {

  FieldTitle({this.title, this.subtititle});

  final String title;
  final String subtititle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3, bottom: 4),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Text(
            '$title  ', style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          ),
          Text(
            '$subtititle  ', style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          )
        ],
      ),
    );
  }

}