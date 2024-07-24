import 'dart:async';
import 'dart:developer';


import 'package:adast_seller/models/cloth_model.dart';
import 'package:adast_seller/services/category_database_services.dart';
import 'package:adast_seller/services/item_database_services.dart';
import 'package:adast_seller/methods/network_check.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'add_update_event.dart';
part 'add_update_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  late ClothModel clothModel;
  AddBloc() : super(AddInitial()) {
    on<SaveButtonPressedEvent>(saveButtonPressedEvent);
  }

  FutureOr<void> saveButtonPressedEvent(
      SaveButtonPressedEvent event, Emitter<AddState> emit) async {
        log(clothModel.category);
        log(clothModel.fit);
        log(clothModel.size.toString());
    emit(SaveButtonPressedState());
    if (!await hasNetwork()) {
      emit(NetworkErrorState());
    } else if (!event.formkey.currentState!.validate() ||
        clothModel.images.isEmpty ||
        clothModel.category == '' ||
        clothModel.fit == '' ||
        clothModel.size.isEmpty) {
      emit(AddNotCompletedState(message: 'Please fill all field'));
    } else {
      bool flag = false;
      clothModel.size.forEach(
        (key, value) {
          if (value < clothModel.reservableCount[key]) {
            flag = true;
          }
        },
      );
      if (flag) {
        emit(AddNotCompletedState(
            message: 'Reservable count cannot be larger than total count'));
        return;
      }
      try {
        await CategoryDatabaseServices().addCategory(clothModel.category);
        if(clothModel.id==null)
        {
          await ItemDatabaseServices().addItem(clothModel);
        }
        else{
          await ItemDatabaseServices().updateItem(clothModel);
        }
        
        log('success');
        emit(AddUpadateSavedSuccessState());
      } on FirebaseException catch (e) {
        log(e.code);
      }
    }
  }
}
