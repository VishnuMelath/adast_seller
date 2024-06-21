import 'dart:async';

import 'package:adast_seller/models/cloth_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'update_item_event.dart';
part 'update_item_state.dart';

class UpdateItemBloc extends Bloc<UpdateItemEvent, UpdateItemState> {
   ClothModel clothModel;
  UpdateItemBloc(this.clothModel) : super(UpdateItemInitial()) {
    on<UpdateButtonClickedEvent>(updateButtonClickedEvent);
  }

  FutureOr<void> updateButtonClickedEvent(UpdateButtonClickedEvent event, Emitter<UpdateItemState> emit) {
  }
}
