import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:adast_seller/features/wallet/UI/wallet.dart';
import 'package:adast_seller/features/wallet/bloc/wallet_bloc.dart';
import 'package:adast_seller/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget walletWidget(BuildContext context,
    {required SellerModel sellerModel, required DashboardBloc dashboardBloc}) {
  WalletBloc walletBloc = WalletBloc(sellerModel: sellerModel);
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => walletBloc,
              child: const Wallet(),
            ),
          ));
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.orange),
      child: Column(
        children: [
          Text(
            'Wallet',
            style: whiteHeadTextStyle,
          ),
          Text(
            '₹${sellerModel.wallet ~/ 100}',
            style: whiteTextStyle,
          )
        ],
      ),
    ),
  );
}
