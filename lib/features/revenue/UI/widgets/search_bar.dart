import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/revenue/UI/widgets/sort_revenue.dart';
import 'package:adast_seller/features/revenue/bloc/revenue_bloc.dart';
import 'package:adast_seller/methods/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../login_screen/bloc/login_bloc.dart';

Widget customSearchBar(BuildContext context,{required RevenueBloc revenueBloc}) {
  Debouncer debouncer=Debouncer(500);
  return Container(
    margin:const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
    decoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
    child: Material(
      borderRadius: BorderRadius.circular(10),
      color: greentransparent,
      elevation: 2,
      child: TextField(
        onChanged: (value) {
          revenueBloc.querry=value;
          debouncer.call(() {
            revenueBloc.add(RevenueTileLoadingEvent(
                email: context.read<LoginBloc>().sellerModel!.email));
          },);
        },
       style: whiteTextStyle,
        decoration: InputDecoration(
          hintText: 'search...',
          hintStyle: greyMediumTextStyle,
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search,color: white,),
            suffixIcon:
                IconButton(onPressed: () {
                  showSortBottomSheetRevenue(context, revenueBloc);
                }, icon: const Icon(Icons.sort,color: white,))),
      ),
    ),
  );
}
