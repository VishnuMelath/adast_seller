
import 'package:flutter/material.dart';

import '../ themes/colors_shemes.dart';
import '../ themes/themes.dart';

AppBar customAppBar(String title,BuildContext context)
{
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(onPressed: () {
      Navigator.pop(context);
    }, icon:const Icon(Icons.arrow_back,color: greentransparent,)),
    title: Text(title,style: greenTextStyle,),backgroundColor: backgroundColor,);
}