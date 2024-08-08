import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/revenue/UI/widgets/custom_radio.dart';
import 'package:adast_seller/features/revenue/bloc/revenue_bloc.dart';
import 'package:flutter/material.dart';

void showSortBottomSheetRevenue(BuildContext context, RevenueBloc revenueBloc) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    isDismissible: true,
    context: context,
    builder: (context) => Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*.0),
          child: Text('Sort by',style: greyTextStyle,),
        ),
        CustomRadio(label: 'Revenue : low to high', revenueBloc: revenueBloc, index: 1),
        CustomRadio(label: 'Revenue : high to low', revenueBloc: revenueBloc, index: 2),
        CustomRadio(label: 'Sold : low to high', revenueBloc: revenueBloc, index: 3),
        CustomRadio(label: 'Sold : high to low', revenueBloc: revenueBloc, index: 4),
        CustomRadio(label: 'item left : low to high', revenueBloc: revenueBloc, index: 5),
        CustomRadio(label: 'item left: high to low', revenueBloc: revenueBloc, index: 6),
        const SizedBox(height: 30,)
      ],
    ),
  );
}
