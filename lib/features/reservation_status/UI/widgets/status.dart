
import 'package:flutter/material.dart';

import '../../../../ themes/constants.dart';
import '../../../../ themes/themes.dart';
import '../../../../models/reservation_model.dart';

Widget statusWidget(ReservationModel reservation) {
  var days = reservation.reservationTime
      .add(Duration(days: reservation.days))
      .difference(DateTime.now())
      .inDays;
  var hours = reservation.reservationTime
          .add(Duration(days: reservation.days))
          .difference(DateTime.now())
          .inHours %
      24;
  var minutes = reservation.reservationTime
          .add(Duration(days: reservation.days))
          .difference(DateTime.now())
          .inMinutes %
      60;
  var difference = '';
  if (days > 0) {
    difference += '$days days ';
  }
  if (hours > 0) {
    difference += '$hours hours ';
  }
  difference += '$minutes minutes';
  String text = reservation.status == ReservationStatus.purchased.name
      ? 'Order Completed'
      : reservation.reservationTime
              .add(Duration(days: reservation.days))
              .isBefore(DateTime.now())
          ? 'customer failed to purchase the product '
          : '$difference left to pick';
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: greyTextStyle,
      ),
      const SizedBox(
        height: 20,
      ),
      
    ],
  );
}
