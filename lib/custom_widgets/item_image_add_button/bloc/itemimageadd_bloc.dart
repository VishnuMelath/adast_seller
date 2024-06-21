import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:adast_seller/custom_widgets/item_image_add_button/methods/image_pick.dart';
import 'package:adast_seller/methods/network_check.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

import '../../../services/firebase_storage_services.dart';

part 'itemimageadd_event.dart';
part 'itemimageadd_state.dart';

class ItemimageaddBloc extends Bloc<ItemimageaddEvent, ItemimageaddState> {
  List images = [];
  ItemimageaddBloc() : super(ItemimageaddInitial()) {
    on<ItemImagesAddPressedEvent>(itemImagesAddPressedEvent);
    on<ItemImageRemoveEvent>(itemImageRemoveEvent);
  }

  FutureOr<void> itemImagesAddPressedEvent(
      ItemImagesAddPressedEvent event, Emitter<ItemimageaddState> emit) async {
    if (!await hasNetwork()) {
      emit(ItemImageErrorState(error: 'Please check your internet connection'));
      return;
    }
    var tempList = await pickMultiImage();
    emit(ItemImageUploadingState(count: tempList.length));
    try {
      for (var item in tempList) {
        var link = await FirebaseStorageServices()
            .uploadImageToFirebase(File(item), 'item');
        if (link != null) {
          images.add(link);
        }
      }
      emit(ItemListUpdatedState());
    } on FirebaseException catch (e) {
      emit(ItemImageErrorState(error: 'Failed to upload Image'));
      log(e.code);
    }
  }

  FutureOr<void> itemImageRemoveEvent(
      ItemImageRemoveEvent event, Emitter<ItemimageaddState> emit) async{
    images.remove(event.path);
    try {
      await FirebaseStorageServices().deleteImageFromUrl(event.path);
      emit(ItemListUpdatedState());
    } on FirebaseException {
      emit(ItemImageErrorState(error: 'Failed to delete Image . Try again!'));
    }
  }

  FutureOr<void> itemimageaddInitial(
      ItemimageaddInitial event, Emitter<ItemimageaddState> emit) {}
}
