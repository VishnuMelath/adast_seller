
import 'package:flutter/material.dart';

import '../../../../ themes/themes.dart';
import '../../bloc/reservation_status_bloc.dart';

Widget clothDetail(ReservationStatusBloc reservationStatusBloc) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          reservationStatusBloc.clothModel!.brand,
          style: greenTextStyle,
        ),
        Text(
          reservationStatusBloc.clothModel!.name,
          style: mediumBlackTextStyle,
        ),
        Text(
          'price : ₹${reservationStatusBloc.clothModel!.price}',
          style: greyMediumTextStyle,
        ),
        Text(
          'Amount paid : ₹${reservationStatusBloc.reservationModel.amount ~/ 100}',
          style: greyMediumTextStyle,
        ),
         Text(
          'Size : ${reservationStatusBloc.reservationModel.size}',
          style: greyMediumTextStyle,
        ),
      ],
    ),
  );
}
