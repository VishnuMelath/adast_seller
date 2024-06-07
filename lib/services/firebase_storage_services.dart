import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageServices
{
  Future<String> uploadImageToFirebase(File imageFile,String email) async {
  final storage = FirebaseStorage.instance;
  final filename = '$email.jpg';
  final reference = storage.ref().child('images/$filename');
  final uploadTask = reference.putFile(imageFile);

  uploadTask.snapshotEvents.listen((event) {
    final progress = event.bytesTransferred / event.totalBytes * 100;
    log('Upload progress: $progress%');
  });
  final snapshot = await uploadTask.whenComplete(() => null);
  return await snapshot.ref.getDownloadURL();
}

}