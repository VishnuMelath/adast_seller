
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../ themes/colors_shemes.dart';

Widget loadingTile()
{
  return  Padding(
    padding: const EdgeInsets.only(left :8.0,top: 8,right: 8),
    child: Shimmer.fromColors(
      baseColor: white.withOpacity(0.1),
      highlightColor: backgroundColor,
      child: Container(
        decoration: BoxDecoration(
           color: white,
          borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        height: 80,
       
      ),
    
    ),
  );
}