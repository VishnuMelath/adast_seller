import 'dart:async';
import 'dart:io';

import 'package:adast_seller/custom_widgets/image_icon/methods/methods.dart';
import 'package:adast_seller/services/firebase_storage_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
    String? image = await pickImageFromCamera();
    emit(ImagePickCompleteState());
    if (image != null) {
      emit(ImageIconChangedState(imageUrl: null, loading: true));
      await FirebaseStorageServices()
          .uploadImageToFirebase(File(image), 'vishnumeloth13@gmai.com');
      emit(ImageIconChangedState(imageUrl: image, loading: false));
    }
  }

  FutureOr<void> galaryIconPressedEvent(
      GalaryIconPressedEvent event, Emitter<ImageIconState> emit) async {
    String? image = await pickImageFromGallery();
    emit(ImagePickCompleteState());
    if (image != null) {
      emit(ImageIconChangedState(imageUrl: null, loading: true));
      image = await FirebaseStorageServices()
          .uploadImageToFirebase(File(image), 'vishnumeloth@gmai.com');
      if (image != null) {
        imageUrl = image;
        emit(ImageIconChangedState(imageUrl: image, loading: false));
      }
    }
  }
}
