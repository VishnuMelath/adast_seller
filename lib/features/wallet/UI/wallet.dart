import 'dart:developer';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/wallet/UI/widgets/loaded_tiles_wallet.dart';
import 'package:adast_seller/features/wallet/UI/widgets/loading_tiles_wallet.dart';
import 'package:adast_seller/features/wallet/UI/widgets/wallet_card.dart';
import 'package:adast_seller/features/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    WalletBloc walletBloc = context.read()
      ..add(WalletTransactionsLoadingEvent());
    return Container(
      color: white,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              walletCard(walletBloc),
              Text(
                'Transactions',
                style: largeBlackTextStyle,
              ),
              BlocBuilder(
                buildWhen: (previous, current) =>
                    current is WalletTransactionsLoadingState ||
                    current is WalletTransactionsLoadedState,
                bloc: walletBloc,
                builder: (context, state) {
                  log(state.runtimeType.toString());
                  if (state is WalletTransactionsLoadingState) {
                    return loadingTilesWallet(4);
                  } else if (state is WalletTransactionsLoadedState) {
                    return loadedTilesWallet(walletBloc);
                  } else {
                    return loadingTilesWallet(1);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
