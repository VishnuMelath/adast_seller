import 'package:adast_seller/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../ themes/colors_shemes.dart';
import '../../../../../ themes/themes.dart';
import '../../../../../methods/common_methods.dart';

AppBar appBarChatRoom(UserModel user)
{
  return  AppBar(
            titleSpacing: 0,
            leadingWidth: 40,
            backgroundColor: backgroundColor,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                        width: 40, imageUrl: user.image!)),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  capitalize(user.name),
                  style: blackTextStyle,
                ),
              ],
            ),
          );
}