import 'dart:async';
import 'dart:developer';

import 'package:adast_seller/models/cloth_model.dart';
import 'package:adast_seller/services/item_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  List<ClothModel> items = [];
  List<ClothModel> showingItems = [];
  InventoryBloc() : super(InventoryInitial()) {
    on<InventoryInitialEvent>(inventoryInitialEvent);
    on<InventoryAddButtonPressedEvent>(inventoryAddButtonPressedEvent);
    // on<InventorySortEvent>
  }

  FutureOr<void> inventoryInitialEvent(
      InventoryInitialEvent event, Emitter<InventoryState> emit) async {
    emit(InventoryLoadingState());
    try {
      items = await ItemDatabaseServices().getAllItems(event.email);
      showingItems=items;
      if(items.isEmpty)
      {
        emit(InventoryEmptyState());
      }
      else
      {
            emit(InventoryLoadedState());
      }

    } on FirebaseException catch (e) {
      log(e.code);
    }
  }

  FutureOr<void> inventoryAddButtonPressedEvent(
      InventoryAddButtonPressedEvent event, Emitter<InventoryState> emit) {
    emit(InventoryNavigateToAddItemState());
  }
}
