import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_icon_event.dart';
part 'image_icon_state.dart';

class ImageIconBloc extends Bloc<ImageIconEvent, ImageIconState> {
  ImageIconBloc() : super(ImageIconInitial()) {
    on<ImageIconPressedEvent>(imageIconPressedEvent);
    on<CameraIconPressedEvent>(cameraIconPressedEvent);
    on<GalaryIconPressedEvent>(galaryIconPressedEvent);
  }

  FutureOr<void> imageIconPressedEvent(ImageIconPressedEvent event, Emitter<ImageIconState> emit) {
    emit(ImageIconShowBottomSheetState());
  }

  FutureOr<void> cameraIconPressedEvent(CameraIconPressedEvent event, Emitter<ImageIconState> emit) {
  }

  FutureOr<void> galaryIconPressedEvent(GalaryIconPressedEvent event, Emitter<ImageIconState> emit) {
  }
}
