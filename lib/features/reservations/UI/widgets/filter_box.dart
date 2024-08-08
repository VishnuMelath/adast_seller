

import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';
import '../../bloc/reservations_bloc.dart';

Widget filterBox({required String selected,required String value,required ReservationsBloc reservationsBloc})
{
  return GestureDetector(
    onTap: () {
      reservationsBloc.add(ReservationsFilterSelectedEvent(value: value));
    },
    child: Container(
      // height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color:selected==value? greentransparent:white,borderRadius: BorderRadius.circular(10)),
      child: Text(value,style: selected!=value? greenTextStyle:whiteTextStyle,),
    ),
  );
}