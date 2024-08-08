import 'dart:async';
import 'dart:developer';

import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/models/seller_model.dart';
import 'package:adast_seller/services/auth.dart';
import 'package:adast_seller/services/item_database_services.dart';
import 'package:adast_seller/services/reservation_databaase_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  SplashscreenBloc() : super(SplashscreenInitial()) {
    on<SplashLoadingEvent>(splashLoadingEvent);
  }

  FutureOr<void> splashLoadingEvent(
      SplashLoadingEvent event, Emitter<SplashscreenState> emit) async {
    late SellerModel? seller;
    emit(SplashLoginCheckingState());

    //todo -check wheather the user already logged in or not
    await Future.delayed(
      const Duration(seconds: 0),
      () async {
        seller = await LoginService().getSeller();
      },
    );
    if (seller == null) {
      emit(SplashNavigatetoLoginState());
    } else {  
      var reservations=await ReservationDatabaseServices().loadReservations(seller!.email);
      log('${seller?.id}');
      log(reservations.length.toString());
      for(var item in reservations)
      {   
        if(item.reservationTime.add(Duration(days: item.days)).isBefore(DateTime.now())&&item.status==ReservationStatus.reserved.name)
        {
          item.status=ReservationStatus.cancelled.name;
          await ReservationDatabaseServices().updateReservation(item);
          await ItemDatabaseServices().updateItemReserved(item.itemId,item.size);
        }
      }
      emit(SplashNavigateToHomeState(sellerModel: seller!));
    }
  }
}
