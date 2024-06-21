import 'dart:async';

import 'package:adast_seller/models/cloth_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'item_details_event.dart';
part 'item_details_state.dart';

class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
   ClothModel item;
  ItemDetailsBloc({required this.item}) : super(ItemDetailsInitial()) {
    on<ItemDetailsChangedEvent>(itemDetailChangedEvent);
  }

  FutureOr<void> itemDetailChangedEvent(ItemDetailsChangedEvent event, Emitter<ItemDetailsState> emit) {
    emit(ItemDetailsChangedState(item: event.item));
  }
}
