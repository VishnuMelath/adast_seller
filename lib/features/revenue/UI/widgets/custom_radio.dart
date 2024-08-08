import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/revenue/bloc/revenue_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../login_screen/bloc/login_bloc.dart';

class CustomRadio extends StatelessWidget {
  final String label;
  final RevenueBloc revenueBloc;
  final int index;
  const CustomRadio(
      {super.key,
      required this.label,
      required this.revenueBloc,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          groupValue: revenueBloc.sortOption,
          value: index,
          onChanged: (value) {
            revenueBloc.sortOption = value as int;
            revenueBloc.add(RevenueTileLoadingEvent(
                email: context.read<LoginBloc>().sellerModel!.email));
            Navigator.pop(context);
          },
        ),
        Text(
          label,
          style: blackTextStyle,
        )
      ],
    );
  }
}
