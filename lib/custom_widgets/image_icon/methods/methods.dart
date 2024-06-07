import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future pickImageFromGallery() async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image != null) {}
  return image;
}

Future pickImageFromCamera() {
  var image = ImagePicker().pickImage(source: ImageSource.camera);
  return image;
}

Future<String?> cropImage(String imagePath) async {
  var croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: green,
          toolbarWidgetColor: white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        )
      ]);

  return croppedFile?.path;
}
