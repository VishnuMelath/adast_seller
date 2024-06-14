import 'dart:async';
import 'package:adast_seller/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {
    on<DrawerLogoutPressedEvent>(drawerLogoutPressedEvent);
    on<DrawerOptionTappedEvent>(drawerOptionTappedEvent);
  }

  FutureOr<void> drawerLogoutPressedEvent(DrawerLogoutPressedEvent event, Emitter<DrawerState> emit) async{
   await LoginService().logout();
   emit(DrawerLogoutPressedState());
  }

  FutureOr<void> drawerOptionTappedEvent(DrawerOptionTappedEvent event, Emitter<DrawerState> emit) {
    emit(DrawerOptionState(index: event.index));
  }
}
