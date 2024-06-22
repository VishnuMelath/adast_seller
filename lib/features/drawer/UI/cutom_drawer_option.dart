import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:flutter/material.dart';

Widget customListTile(Function() onTap,String title)
{
return ListTile(
  onTap: onTap,
  leading: Icon(icons[title],color: green,),
  title: Text(title,style: blackTextStyle,),
);
}