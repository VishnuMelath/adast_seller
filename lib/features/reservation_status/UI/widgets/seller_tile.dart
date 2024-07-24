
import 'package:adast_seller/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/themes.dart';
import '../../bloc/reservation_status_bloc.dart';
import 'network_image.dart';


class SellerTile extends StatelessWidget {
  final ReservationStatusBloc reservationStatusBloc;
  const SellerTile({super.key,required this.reservationStatusBloc});

  @override
  Widget build(BuildContext context) {
    UserModel userModel=reservationStatusBloc.userModel!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        networkImageUsingWidth(userModel.image!, 50),
        const SizedBox(width: 10,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userModel.name,style: mediumBlackTextStyle,),
          // Text(sellerModel.place,style: greySmallTextStyle,),
        ],
      ),
      ]
         
        );
  }
}
