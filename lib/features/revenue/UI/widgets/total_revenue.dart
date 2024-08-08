import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/revenue/bloc/revenue_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget totalRevenue(BuildContext context, {required RevenueBloc revenueBloc}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: BlocBuilder<RevenueBloc, RevenueState>(
      bloc: revenueBloc,
      builder: (context, state) {
        return Material(
          color: green,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 100,
            child: Center(
              child: revenueBloc.totalRevenue == null
                  ? const CircularProgressIndicator()
                  : Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Total revenue',
                                style: whiteHeadTextStyle,
                              ),
                              Text(
                                '₹${revenueBloc.totalRevenue}',
                                style: whiteHeadTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    ),
  );
}
