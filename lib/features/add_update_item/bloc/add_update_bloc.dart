import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:adast_seller/models/cloth_model.dart';
import 'package:adast_seller/services/firebase_storage_services.dart';
import 'package:adast_seller/services/item_database_services.dart';
import 'package:adast_seller/services/network_check.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'add_update_event.dart';
part 'add_update_state.dart';

class AddUpdateBloc extends Bloc<AddUpdateEvent, AddUpdateState> {
  late ClothModel clothModel;
  AddUpdateBloc() : super(AddUpdateInitial()) {
    on<SaveButtonPressedEvent>(saveButtonPressedEvent);
  }

  FutureOr<void> saveButtonPressedEvent(
      SaveButtonPressedEvent event, Emitter<AddUpdateState> emit) async {
    emit(SaveButtonPressedState());
    if (!await hasNetwork()) {
      emit(NetworkErrorState());
    } else if (!event.formkey.currentState!.validate() ||
        clothModel.images.isEmpty ||
        clothModel.category == '' ||
        clothModel.fit == '' ||
        clothModel.size.isEmpty) {
      emit(AddUpdateNotCompletedState(message: 'Please fill all field'));
    } else {
      List<String> images = [];
      for (var element in clothModel.images) {
        try {
          var image = await FirebaseStorageServices()
              .uploadImageToFirebase(File(element), 'item');
          images.add(image!);
        } on FirebaseException catch (e) {
          log(e.code);
        }
      }
      clothModel.images = images;
      try {
        await ItemDatabaseServices().addItem(clothModel);
        log('success');
        emit(AddUpadateSavedSuccessState());
      } on FirebaseException catch (e) {
        log(e.code);
      }
    }
  }
}
