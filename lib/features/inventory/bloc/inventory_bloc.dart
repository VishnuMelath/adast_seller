import 'dart:async';

import 'package:adast_seller/models/cloth_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  List<ClothModel> items=[];
  InventoryBloc() : super(InventoryInitial()) {
    on<InventoryInitialEvent>(inventoryInitialEvent);
    on<InventoryAddButtonPressedEvent>(inventoryAddButtonPressedEvent);
  }

  FutureOr<void> inventoryInitialEvent(InventoryInitialEvent event, Emitter<InventoryState> emit) {
    emit(InventoryLoadingState());
  }

  FutureOr<void> inventoryAddButtonPressedEvent(InventoryAddButtonPressedEvent event, Emitter<InventoryState> emit) {
    emit(InventoryNavigateToAddItemState());
  }
}
