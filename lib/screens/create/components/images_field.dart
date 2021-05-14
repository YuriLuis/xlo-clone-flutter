import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/create/components/images_source_dialog.dart';

class ImagesField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void onImageSelected(File image){
      Navigator.of(context).pop();
    }
    return Container(
      color: Colors.grey[200],
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: GestureDetector(
              onTap: () {
                if (Platform.isAndroid) {
                  ///Dialog para SO Android
                  showModalBottomSheet(context: context, builder: (_) => ImagesSourceDialog(onImageSelected));
                } else {
                  ///Dialog para SO IOS
                  showCupertinoModalPopup(context: context, builder: (_) => ImagesSourceDialog(onImageSelected));
                }
              },
              child: CircleAvatar(
                radius: 44,
                backgroundColor: Colors.purple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      '+',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
