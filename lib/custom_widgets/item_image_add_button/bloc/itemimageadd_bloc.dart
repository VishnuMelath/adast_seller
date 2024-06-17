import 'dart:async';

import 'package:adast_seller/custom_widgets/item_image_add_button/methods/image_pick.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'itemimageadd_event.dart';
part 'itemimageadd_state.dart';

class ItemimageaddBloc extends Bloc<ItemimageaddEvent, ItemimageaddState> {
  List<String> images=[];
  ItemimageaddBloc() : super(ItemimageaddInitial()) {
    on<ItemImagesAddPressedEvent>(itemImagesAddPressedEvent);
    on<ItemImageRemoveEvent>(itemImageRemoveEvent);
  }

  FutureOr<void> itemImagesAddPressedEvent(ItemImagesAddPressedEvent event, Emitter<ItemimageaddState> emit) async{
    images.addAll(await pickMultiImage());
    emit(ItemListUpdatedState());

  }

  FutureOr<void> itemImageRemoveEvent(ItemImageRemoveEvent event, Emitter<ItemimageaddState> emit) {
    images.remove(event.path);
    emit(ItemListUpdatedState());
  }
}
