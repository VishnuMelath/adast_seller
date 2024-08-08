import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:flutter/material.dart';

Widget customListTile({required Function() onTap,required String title,required bool tapped})
{
return Padding(
  padding: const EdgeInsets.only(left: 8.0),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: ListTile(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10))),
      tileColor:tapped? greentransparent:Colors.transparent,
      onTap: onTap,
      leading: Icon(icons[title],color:tapped?white: green,),
      title: Text(title,style:tapped?whiteTextStyle: blackTextStyle,),
    ),
  ),
);
}