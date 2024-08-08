
import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/features/dashboard/UI/widgets/custom_bar_chart.dart';
import 'package:adast_seller/features/dashboard/UI/widgets/tatal_reservation_stati.dart';
import 'package:adast_seller/features/dashboard/UI/widgets/wallet.dart';
import 'package:adast_seller/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ themes/themes.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    SellerModel sellerModel=context.read<LoginBloc>().sellerModel!;
    ValueNotifier swipedRight=ValueNotifier(true);
    DashboardBloc dashboardBloc = DashboardBloc()
  
      ..add(DashboardInitialEvent(
          sellerId: context.read<LoginBloc>().sellerModel!.email));
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocBuilder<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        builder: (context, state) {
          if (state is DashboardLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
          
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  walletWidget(context, sellerModel: sellerModel, dashboardBloc: dashboardBloc),
                  Text(
                  'Reservations Overview',
                  style: blackTextStyle,
                ),
                customWrap(dashboardBloc),
               customBarChart(context, dashboardBloc: dashboardBloc,swipedRight: swipedRight)
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
