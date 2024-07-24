
import 'package:adast_seller/methods/common_methods.dart';
import 'package:adast_seller/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';
import '../../../../models/cloth_model.dart';
import '../../../reservation_status/bloc/reservation_status_bloc.dart';
import 'network_image.dart';
import 'status.dart';

Widget loadedTile(ReservationStatusBloc reservationsBloc,Function()? onTap,BuildContext context) {
  ClothModel item=reservationsBloc.clothModel!;
  UserModel userModel=reservationsBloc.userModel!; 
  return Padding(
    padding: const EdgeInsets.only(left :8.0,top: 8,right: 8),
    child: InkWell(
      onTap:onTap ,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
              ),
          padding: const EdgeInsets.all(8),
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              networkImage(item.images.first, 64),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        capitalize(item.name),
                        style: mediumBlackTextStyle,
                      ),
                      Text(
                       'Reserved by ${capitalize(userModel.name)}',
                        style: greySmallTextStyle,
                      ),
                      Expanded(child: statusWidget1(reservationsBloc.reservationModel))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
