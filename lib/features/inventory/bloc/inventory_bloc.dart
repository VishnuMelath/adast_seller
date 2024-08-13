import 'dart:async';
import 'dart:developer';

import 'package:adast_seller/features/inventory/methods/methods.dart';
import 'package:adast_seller/models/cloth_model.dart';
import 'package:adast_seller/services/item_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  String searchQuery = '';
  int maxPrice = 100;
  int minPrice = 0;
  List<ClothModel> items = [];
  Set<ClothModel> showingItems = {};
  Set<String> brands = {};
  Set<String> categories = {};
  List<String> selectedBrands = [];
  List<String> selectedFabric = [];
  List<String> selectedFit = [];
  List<String> selectedCategory = [];
  RangeValues priceRangeValues = const RangeValues(0, 10000);
  int sortOption = 0;
  InventoryBloc() : super(InventoryInitial()) {
    on<InventoryInitialEvent>(inventoryInitialEvent);
    on<InventoryAddButtonPressedEvent>(inventoryAddButtonPressedEvent);
    on<InventorySearchEvent>(inventorySearchEvent);
    on<InventoryClearFilterEvent>(inventoryClearFilterEvent);
  }

  FutureOr<void> inventoryClearFilterEvent(
      InventoryClearFilterEvent event, Emitter<InventoryState> emit) async {
    emit(InventoryLoadingState());
    selectedBrands.clear();
    selectedCategory.clear();
    selectedFabric.clear();
    selectedFit.clear();
    priceRangeValues = const RangeValues(0, 10000);
    sortOption = 0;
    showingItems.addAll(items);

    await Future.delayed(const Duration(milliseconds: 200));
   if (items.isEmpty) {
        emit(InventoryEmptyState());
      } else {
        emit(InventoryLoadedState());
      }
  }

  FutureOr<void> inventorySearchEvent(
      InventorySearchEvent event, Emitter<InventoryState> emit) async {
    emit(InventoryLoadingState());
    showingItems.clear();
    log('${sortOption}sort option');
    showingItems.addAll(items.where(
      (element) => element.name.contains(searchQuery),
    ));
    if (selectedBrands.isNotEmpty) {
      log(selectedBrands.toString());
      showingItems = showingItems.where(
        (e) {
          log(e.brand);
          return selectedBrands.contains(e.brand);
        },
      ).toSet();
    }
    if (selectedCategory.isNotEmpty) {
      log(showingItems.length.toString());
      showingItems = showingItems.where(
        (e) {
          log(e.category);
          return selectedCategory.contains(e.category);
        },
      ).toSet();
      log(showingItems.length.toString());
    }
    if (selectedFabric.isNotEmpty) {
      log(selectedFabric.toString());
      showingItems = showingItems
          .where(
            (e) => selectedFabric.contains(e.material),
          )
          .toSet();
    }
    if (selectedFit.isNotEmpty) {
      log(selectedFit.toString());
      showingItems = showingItems
          .where(
            (e) => selectedFit.contains(e.fit),
          )
          .toSet();
    }

    showingItems = showingItems
        .where(
          (element) =>
              element.price <= priceRangeValues.end &&
              element.price >= priceRangeValues.start,
        )
        .toSet();

    if (sortOption != 0) {
      log(sortOption.toString());
      var temp = showingItems.toList();
      switch (sortOption) {
        //price ascending order
        case 1:
          temp.sort((a, b) => a.price.compareTo(b.price));
          break;
        //price desc order
        case 2:
          temp.sort((a, b) => b.price.compareTo(a.price));
          break;
        //date ascending order
        case 3:
          temp.sort((a, b) => a.date.compareTo(b.date));
          break;
        //date desc order
        case 4:
          temp.sort((a, b) => b.date.compareTo(a.date));
          break;
        //item left ascending order
        case 5:
          temp.sort((a, b) => totalItemsLeft(a).compareTo(totalItemsLeft(b)));
          break;
        //itemleft desc order
        case 6:
          temp.sort((a, b) => totalItemsLeft(b).compareTo(totalItemsLeft(a)));
          break;

        default:
          break;
      }
      showingItems = temp.toSet();
    }
    if (showingItems.isEmpty) {
      emit(InventoryEmptyState());
    } else {
      await Future.delayed(const Duration(milliseconds: 200));

      emit(InventoryLoadedState());
    }
  }

  FutureOr<void> inventoryInitialEvent(
      InventoryInitialEvent event, Emitter<InventoryState> emit) async {
    emit(InventoryLoadingState());
    try {
      items = await ItemDatabaseServices().getAllItems(event.email);
      if (items.isNotEmpty) {
  minPrice = items.first.price;
}
      for (var item in items) {
        if (item.price < minPrice) {
          minPrice = item.price;
        }
        if (item.price > maxPrice) {
          maxPrice = item.price;
        }
        brands.add(item.brand);
        categories.add(item.category);
      }

      showingItems = items.toSet();
      if (items.isEmpty) {
        emit(InventoryEmptyState());
      } else {
        emit(InventoryLoadedState());
      }
    } on FirebaseException catch (e) {
      log(e.code);
      emit(InventoryErrorState(error: e.code));
    }
  }

  FutureOr<void> inventoryAddButtonPressedEvent(
      InventoryAddButtonPressedEvent event, Emitter<InventoryState> emit) {
    emit(InventoryNavigateToAddItemState());
  }
}
