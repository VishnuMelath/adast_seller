import 'package:adast_seller/%20themes/constants.dart';
import 'package:flutter/material.dart';

class ImageIcon extends StatelessWidget {
  const ImageIcon({super.key});

  @override
  Widget build(BuildContext context) {
    String imageAddress=imagePath;
     return Stack(
      children: [
        CircleAvatar(
          child: Image.network(imageAddress),
        )
      ],
    );
  }
}