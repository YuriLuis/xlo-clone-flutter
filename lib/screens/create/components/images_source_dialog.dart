import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagesSourceDialog extends StatelessWidget {

  ImagesSourceDialog(this.onImageSelected);

  final Function(File) onImageSelected;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(onPressed: getFromCamera, child: Text('Câmera')),
            FlatButton(onPressed: getFromGallery, child: Text('Galeria')),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: getFromCamera, child: Text('Câmera')),
          CupertinoActionSheetAction(
              onPressed: getFromGallery, child: Text('Galeria')),
        ],
      );
    } 
  }

  Future<void> getFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if(pickedFile == null){
      return;
    }
    final image = File((pickedFile.path));
    imageSelected(image);
  }

  Future<void> getFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if(pickedFile == null){
      return;
    }
    final image = File((pickedFile.path));
    imageSelected(image);
  }

  Future<void> imageSelected(File image) async {
    final croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: Colors.purple,
          toolbarWidgetColor: Colors.white),
      iosUiSettings: IOSUiSettings(
        title: 'Editar imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir'
      )
    );

    if(croppedFile != null){
      onImageSelected(croppedFile);
    }
  }
}
