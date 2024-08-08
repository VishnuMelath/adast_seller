import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../revenue/UI/widgets/revenue_tile.dart';

Widget customWrap(DashboardBloc dashboardBloc) {
  Map<String,int> count={
    ReservationStatus.cancelled.name:0,
    ReservationStatus.purchased.name:0,
    ReservationStatus.reserved.name:0
  };
  for (var element in dashboardBloc.reservaions) {
  count[ReservationStatus.reserved.name]=count[ReservationStatus.reserved.name]!+1;
  if(ReservationStatus.purchased.name==element.status)
  {
    count[ReservationStatus.purchased.name]= count[ReservationStatus.purchased.name]!+1;
  }
  else if(ReservationStatus.cancelled.name==element.status)
  {
count[ReservationStatus.cancelled.name]= count[ReservationStatus.cancelled.name]!+1;
  }
  }
  return Wrap(
    alignment: WrapAlignment.spaceAround,
    children: [
      customCard(
          label: 'Total Reservations',
          color: greentransparent,
          count: count[ReservationStatus.reserved.name]!),
          customCard(
          label: 'Completed',
          color: grey,
          count: count[ReservationStatus.purchased.name]!),customCard(
          label: 'Failed',
          color: red,
          count: count[ReservationStatus.cancelled.name]!),
    ],
  );
}

