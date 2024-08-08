import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/wallet/bloc/wallet_bloc.dart';
import 'package:adast_seller/methods/common_methods.dart';
import 'package:adast_seller/models/transaction_model.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';

Widget loadedTileWallet(WalletBloc walletBloc, TransactionModel transaction) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: green,
      gradient: LinearGradient(
          colors: [
            transaction.user == null ? greentransparent : backgroundColor,
            white.withOpacity(0.3),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp),
    ),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: green,
        child: Text(transaction.user == null ? 'A' : capitalize(walletBloc.users[transaction.user!]!.name[0])),
      ),
      title: Text(
        transaction.user == null
            ? 'Money withdrawn'
            : capitalize(walletBloc.users[transaction.user]!.name),
        style: blackPlainTextStyle,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reservation payment',
            style: greyMediumTextStyle,
          ),Text(
            dateTimeString(transaction.time),
            style: greyMediumTextStyle,
          ),
        ],
      ),
      trailing: Text(transaction.user == null
          ? '-${transaction.amount / 100}'
          : '+${transaction.amount / 100}'),
    ),
  );
}

Widget loadedTilesWallet(WalletBloc walletBloc) {
  return Expanded(
    child: ListView.builder(
      itemCount: walletBloc.transactions.length,
      itemBuilder: (context, index) =>
          loadedTileWallet(walletBloc, walletBloc.transactions[index]),
    ),
  );
}
