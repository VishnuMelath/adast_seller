import 'dart:async';

import 'package:adast_seller/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {
    on<DrawerLogoutPressedEvent>(drawerLogoutPressedEvent);
  }

  FutureOr<void> drawerLogoutPressedEvent(DrawerLogoutPressedEvent event, Emitter<DrawerState> emit) async{
   await LoginService().logout();
   emit(DrawerLogoutPressedState());
  }
}
