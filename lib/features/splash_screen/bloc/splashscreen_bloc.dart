import 'dart:async';

import 'package:adast_seller/models/seller_model.dart';
import 'package:adast_seller/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  SplashscreenBloc() : super(SplashscreenInitial()) {
    on<SplashLoadingEvent>(splashLoadingEvent);
  }

  FutureOr<void> splashLoadingEvent(
    
      SplashLoadingEvent event, Emitter<SplashscreenState> emit) async{
        late SellerModel? seller;
    emit(SplashLoginCheckingState());

    //todo -check wheather the user already logged in or not
   await Future.delayed(
      const Duration(seconds: 1),
      () async{
       seller=await LoginService().getSeller();
      },
    );
      if (seller==null) {
          emit(SplashNavigatetoLoginState());
        } 
        else {

          emit(SplashNavigateToHomeState(sellerModel: seller!));
        }

  }
}
