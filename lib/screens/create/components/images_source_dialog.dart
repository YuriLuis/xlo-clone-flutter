import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesSourceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if( Platform.isAndroid){
      return BottomSheet(
        onClosing: (){},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(onPressed: (){}, child: Text('Câmera')),
            FlatButton(onPressed: (){}, child: Text('Galeria')),
          ],
        ),
      );
    }else {
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(onPressed: (){}, child: Text('Câmera')),
          CupertinoActionSheetAction(onPressed: (){}, child: Text('Galeria')),
        ],
      );
    }
  }
}
