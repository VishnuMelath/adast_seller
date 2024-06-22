import 'dart:async';

import 'package:adast_seller/models/cloth_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'item_details_event.dart';
part 'item_details_state.dart';

class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
  ClothModel item;
  late String selectedSize;
  ItemDetailsBloc({required this.item}) : super(ItemDetailsInitial()) {
    selectedSize = item.size.keys.first;
    on<ItemDetailsChangedEvent>(itemDetailChangedEvent);
    on<ItemDetailsSizeChangedEvent>(itemDetailsSizeChangedEvent);
  }

  FutureOr<void> itemDetailChangedEvent(
      ItemDetailsChangedEvent event, Emitter<ItemDetailsState> emit) {
    emit(ItemDetailsChangedState(item: event.item));
  }

  FutureOr<void> itemDetailsSizeChangedEvent(
      ItemDetailsSizeChangedEvent event, Emitter<ItemDetailsState> emit) {
    selectedSize = event.size;
    emit(ItemDetailsSizeChangedState());
  }
}
