import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageServices {
  Future<String?> uploadImageToFirebase(File imageFile,String path) async {
    try {
      final storage = FirebaseStorage.instance;
      // final filename =
      //     '${email.split('@').first}.jpg';
      // log(filename);
      final reference = storage.ref().child('$path/');
      final uploadTask = reference.putFile(imageFile);

      uploadTask.snapshotEvents.listen((event) {
        final progress = event.bytesTransferred / event.totalBytes * 100;
        log('Upload progress: $progress%');
      });
      final snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } on 
    FirebaseException catch (e) {
     log(e.toString());
    }
    return null;
  }
}
