import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/features/revenue/UI/widgets/revenue_tile.dart';
import 'package:adast_seller/features/revenue/UI/widgets/search_bar.dart';
import 'package:adast_seller/features/revenue/UI/widgets/total_revenue.dart';
import 'package:adast_seller/features/revenue/methods/sort.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/revenue_bloc.dart';

class RevenuePage extends StatelessWidget {
  const RevenuePage({super.key});

  @override
  Widget build(BuildContext context) {
    RevenueBloc revenueBloc = RevenueBloc()
      ..add(RevenueTileLoadingEvent(
          email: context.read<LoginBloc>().sellerModel!.email));
    return RefreshIndicator(
      onRefresh: () async {
        revenueBloc.add(RevenueTileLoadingEvent(
            email: context.read<LoginBloc>().sellerModel!.email));
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            customSearchBar(context, revenueBloc: revenueBloc),
            totalRevenue(context, revenueBloc: revenueBloc),
            Expanded(
              child: BlocBuilder<RevenueBloc, RevenueState>(
                bloc: revenueBloc,
                builder: (context, state) {
                  if (state is RevenueLoadedState) {
                    var items = sortedList(revenueBloc,revenueBloc.items);
                    if (items.isEmpty) {
                      return const Center(
                        child: Text('No items found'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount:items.length,
                        itemBuilder: (context, index) => CustomRevenueTile(
                          item: items[index],
                        ),
                      );
                    }
                  } else if (state is RevenueLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
