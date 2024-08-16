import 'dart:async';
import 'dart:typed_data';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../ themes/colors_shemes.dart';

Future<List<Uint8List>> pickMultiImage() async {
  var images = await ImagePicker().pickMultiImage();
  List<Uint8List> croppedImages = [];
  for (var e in images) {
    await cropImage(e.path).then(
      (value) {
        if (value != null) {
          croppedImages.add(value);
        }
      },
    );
  }
  return croppedImages;
}


Future<Uint8List?> cropImage(String imagePath) async {
  var croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1.5),
      uiSettings: [
        AndroidUiSettings(
          showCropGrid: false,
          toolbarTitle: 'Cropper',
          toolbarColor: green,
          toolbarWidgetColor: white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        )
      ]);
 var temp=await croppedFile?.readAsBytes();
  return temp;
}