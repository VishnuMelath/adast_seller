import 'dart:async';

import 'package:image_picker/image_picker.dart';

Future<List<String>> pickMultiImage() async
{
   var images = await ImagePicker().pickMultiImage();
  return images.map((e) => e.path,).toList();
}