import 'dart:async';
import 'package:adast_seller/models/seller_model.dart';
import 'package:adast_seller/services/seller_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEditUserSaveButtonPressedEvent>(
        settingsEditUserSaveButtonPressedEvent);
  }

  FutureOr<void> settingsEditUserSaveButtonPressedEvent(
      SettingsEditUserSaveButtonPressedEvent event,
      Emitter<SettingsState> emit) async {
        try{
          await SellerDatabaseServices().updateSeller(event.sellerModel);
          emit(SettingsSaveSuccessState());
        }
        on FirebaseException catch (e)
        {
          emit(SettingsErrorState(error:e.code));
        }
      }
}
