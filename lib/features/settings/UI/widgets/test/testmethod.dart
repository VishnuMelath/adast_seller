import 'dart:typed_data';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


Future<Uint8List?> tpickImageFromGallery(BuildContext context) async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  Uint8List? croppedFilePath;
  if (image != null) {
    croppedFilePath = await tcropImage(image.path, context);
  }

  return croppedFilePath;
}

Future<Uint8List?> tpickImageFromCamera(BuildContext context) async {
  var image = await ImagePicker().pickImage(source: ImageSource.camera);
  Uint8List? croppedFilePath;
  if (image != null) {
    croppedFilePath = await tcropImage(image.path, context);
  }
  return croppedFilePath;
}

Future<Uint8List?> tcropImage(String imagePath, BuildContext context) async {
  var croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          showCropGrid: false,
          toolbarTitle: 'Cropper',
          toolbarColor: green,
          toolbarWidgetColor: white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        WebUiSettings(
          context: context,
          enableResize: true,
          enableZoom: true,
        
          presentStyle: CropperPresentStyle.page,
          viewPort: CroppieViewPort(
            width: MediaQuery.sizeOf(context).width~/2,
            height:  MediaQuery.sizeOf(context).width~/1.1
          )
        )
      ]);
  var bytes=await croppedFile?.readAsBytes();
  return bytes;
}
