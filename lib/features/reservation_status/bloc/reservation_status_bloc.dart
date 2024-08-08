import 'dart:async';
import 'dart:developer';

import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/models/user_model.dart';
import 'package:adast_seller/services/reservation_databaase_services.dart';
import 'package:adast_seller/services/seller_database_services.dart';
import 'package:adast_seller/services/user_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../models/cloth_model.dart';
import '../../../models/reservation_model.dart';
import '../../../services/item_database_services.dart';

part 'reservation_status_event.dart';
part 'reservation_status_state.dart';

class ReservationStatusBloc
    extends Bloc<ReservationStatusEvent, ReservationStatusState> {
  UserModel? userModel;
  ReservationModel reservationModel;
  ClothModel? clothModel;
  bool reload = false;
  ReservationStatusBloc({required this.reservationModel})
      : super(ReservationStatusInitial()) {
    on<ReservationTileLoadingEvent>(reservationTileLoadingEvent);
    on<ReservationRelodEvent>(reservationReloadEvent);
    on<ReservationMarkAsSoldEvent>(reservationMarkAsSoldEvent);
  }

  FutureOr<void> reservationTileLoadingEvent(ReservationTileLoadingEvent event,
      Emitter<ReservationStatusState> emit) async {
    emit(ReservationTileLoadingState());
    try {
      userModel = await UserDatabaseServices().getUserData(event.userId);

      clothModel =
          await ItemDatabaseServices().getItem(reservationModel.itemId);
      emit(ReservationTileLoadedState());
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  FutureOr<void> reservationReloadEvent(
      ReservationRelodEvent event, Emitter<ReservationStatusState> emit) {
    emit(ReservationTileLoadedState());
  }

  FutureOr<void> reservationMarkAsSoldEvent(ReservationMarkAsSoldEvent event,
      Emitter<ReservationStatusState> emit) async {
    try {
      emit(ReservationTileLoadingState());
      reservationModel.status = ReservationStatus.purchased.name;
      reservationModel.purchasedDate = DateTime.now();
      await ReservationDatabaseServices().updateReservation(reservationModel);
      await ItemDatabaseServices().updateItemRevenue(
          reservationModel.itemId,
          (clothModel!.price * 100) - reservationModel.amount,
          reservationModel.size,
          clothModel!.soldCount.containsKey(reservationModel.size));
      await SellerDatabaseServices().updateSellerWallet(
          (clothModel!.price * 100) - reservationModel.amount,
          reservationModel.sellerId);
      reload = true;
      emit(ReservationTileLoadedState());
    } on FirebaseException catch (e) {
      log(e.code);
    }
  }
}
