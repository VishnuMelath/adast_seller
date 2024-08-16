import 'dart:async';
import 'dart:io';

import 'package:adast_seller/custom_widgets/image_icon/methods/methods.dart';
import 'package:adast_seller/services/firebase_storage_services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'image_icon_event.dart';
part 'image_icon_state.dart';

class ImageIconBloc extends Bloc<ImageIconEvent, ImageIconState> {
  String? imageUrl;
  ImageIconBloc() : super(ImageIconInitial()) {
    on<ImageIconPressedEvent>(imageIconPressedEvent);
    on<CameraIconPressedEvent>(cameraIconPressedEvent);
    on<GalaryIconPressedEvent>(galaryIconPressedEvent);
  }

  FutureOr<void> imageIconPressedEvent(
      ImageIconPressedEvent event, Emitter<ImageIconState> emit) {
    emit(ImageIconShowBottomSheetState());
  }

  FutureOr<void> cameraIconPressedEvent(
      CameraIconPressedEvent event, Emitter<ImageIconState> emit) async {
   var image = await pickImageFromCamera(event.context);
    emit(ImagePickCompleteState());
    if (image != null) {
      emit(ImageIconChangedState(imageUrl: null, loading: true));
     var url= await FirebaseStorageServices()
          .uploadImageToFirebase(image,'profileImages');
      emit(ImageIconChangedState(imageUrl: url, loading: false));
    }
  }

  FutureOr<void> galaryIconPressedEvent(
      GalaryIconPressedEvent event, Emitter<ImageIconState> emit) async {
    var image = await pickImageFromGallery(event.context);
    emit(ImagePickCompleteState());
    if (image != null) {
      emit(ImageIconChangedState(imageUrl: null, loading: true));
     var url = await FirebaseStorageServices()
          .uploadImageToFirebase(image,'profileImages');
      if (url != null) {
        imageUrl = url;
        emit(ImageIconChangedState(imageUrl: url, loading: false));
      }
    }
  }
}
