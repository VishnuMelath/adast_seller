import 'package:adast_seller/%20themes/themes.dart';
import 'package:flutter/material.dart';

Widget customCard(String title, int count,Color color)
{
  return Container(
    color: color,
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: Column(
      children: [ 
        Text(title,style: whiteTextStyle,),
        Text(count.toString(),style: mediumWhiteTextStyle,)
      ],
    ),
  );
}