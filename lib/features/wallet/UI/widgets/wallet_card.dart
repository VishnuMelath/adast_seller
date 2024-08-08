import 'package:adast_seller/features/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';

Widget walletCard(WalletBloc walletBloc){
  return Center(child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      borderRadius: BorderRadius.circular(1000),
      elevation: 5,
      child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                  ,color: greentransparent.withOpacity(.3)
                ),
                padding: const EdgeInsets.all(100),
                child: Column(
                  children: [
                    Text('₹${walletBloc.sellerModel.wallet~/100}',style: whiteHeadTextStyle,),
                    Text('Wallet Balance',style: whiteTextStyle,),
                    // TextButton(
                    //   style: const ButtonStyle(
                    //     backgroundColor: WidgetStatePropertyAll(greentransparent)
                    //   ),
                    //   onPressed: () {
                    //   createContact(walletBloc.sellerModel, 9605391056);
                    // }, child: Text('Withdraw',style: whiteTextStyle,))
                  ],
                )),
    ),
  ));
}