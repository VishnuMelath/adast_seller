import 'dart:async';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../ themes/colors_shemes.dart';

Future<List<String>> pickMultiImage() async {
  var images = await ImagePicker().pickMultiImage();
  List<String> croppedImages = [];
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


Future<String?> cropImage(String imagePath) async {
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

  return croppedFile?.path;
}