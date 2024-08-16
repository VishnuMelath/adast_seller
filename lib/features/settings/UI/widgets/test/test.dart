import 'dart:developer';
import 'dart:typed_data';

import 'package:adast_seller/custom_widgets/image_icon/methods/methods.dart';
import 'package:adast_seller/features/settings/UI/widgets/test/testmethod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Widget widget = Icon(Icons.person);

class TestWidgget extends StatefulWidget {
  const TestWidgget({super.key});

  @override
  State<TestWidgget> createState() => _TestWidggetState();
}

class _TestWidggetState extends State<TestWidgget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            var image = await tpickImageFromGallery(context);

            // if (image != null) {
            //   setState(() {
            //     log(image.toString());
            //     widget = Image.memory(image);
            //   });
            // }
            await uploadFile(image);
          },
          child: CircleAvatar(
            radius: 70,
            child: widget,
          ),
        ),
      ),
    );
  }

  Future<void> uploadFile(Uint8List? _fileData) async {
    try {
      if (_fileData != null) {
        final storageRef = FirebaseStorage.instance.ref().child('uploads/test');
        final uploadTask = storageRef.putData(_fileData);
        uploadTask.snapshotEvents.listen((event) {
          final progress = event.bytesTransferred / event.totalBytes * 100;
          print('Upload progress: $progress%');
        });
        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          widget = CircleAvatar(backgroundImage: NetworkImage(downloadUrl));
        });
      }
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
