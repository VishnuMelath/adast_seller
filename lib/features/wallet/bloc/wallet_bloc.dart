import 'dart:async';
import 'dart:developer';

import 'package:adast_seller/models/seller_model.dart';
import 'package:adast_seller/models/transaction_model.dart';
import 'package:adast_seller/models/user_model.dart';
import 'package:adast_seller/services/reservation_databaase_services.dart';
import 'package:adast_seller/services/transactoin_database_services.dart';
import 'package:adast_seller/services/user_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final SellerModel sellerModel;
  Map<String, UserModel> users = {};
  List<TransactionModel> transactions = [];
  WalletBloc({required this.sellerModel}) : super(WalletInitial()) {
    on<WalletTransactionsLoadingEvent>(walletTransactionsLoadingEvent);
  }

  FutureOr<void> walletTransactionsLoadingEvent(
      WalletTransactionsLoadingEvent event, Emitter<WalletState> emit) async {
    try {
      emit(WalletTransactionsLoadingState());
      transactions.addAll(await ReservationDatabaseServices()
          .loadTransactionsFromReservations(sellerModel.email));
      transactions.addAll(await TransactoinDatabaseServices()
          .getAllTransactions(sellerModel.email));
      for (var items in transactions) {
        if (items.user != null) {
          if (!users.containsKey(items.user)) {
            var user = await UserDatabaseServices().getUserData(items.user!);
            users[items.user!] = user;
          }
        }
      }
      emit(WalletTransactionsLoadedState());
    } on FirebaseException catch (e) {
      log(e.code);
      emit(WalletErrorState());
    }
  }
}
