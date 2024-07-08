import 'dart:async';
import 'dart:developer';

import 'package:adast_seller/services/category_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  Set<String> catagoryFull = {};
  Set<String> catagory = {};
  String? selectedValue;
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryInitialEvent>(categoryInitialEvent);
    on<CategorySelectedEvent>(categorySelectedEvent);
    on<CategorySearchEvent>(categorySearchEvent);
    on<CatagoryAddEvent>(catagoryAddEvent);
  }

  FutureOr<void> categoryInitialEvent(
      CategoryInitialEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    try {
      catagoryFull.addAll(await CategoryDatabaseServices().getAllCategory());
      catagory.addAll(catagoryFull);
    } on FirebaseException catch (e) {
      log(e.toString());
    }
    emit(CategoryLoadedState());
  }

  FutureOr<void> categorySelectedEvent(
      CategorySelectedEvent event, Emitter<CategoryState> emit) {
    selectedValue = event.category;
    emit(CategoryLoadedState());
  }

  FutureOr<void> categorySearchEvent(
      CategorySearchEvent event, Emitter<CategoryState> emit) {
    emit(CategoryLoadingState());
    log(catagoryFull.toString());
    catagory.clear();
    log(catagoryFull.toString());
    for (var element in catagoryFull) {
      log(element.contains(event.query).toString());
      if (element.contains(event.query)) {
        catagory.add(element);
      }
    }
    log(catagory.toString());
    emit(CategoryLoadedState());
  }

  FutureOr<void> catagoryAddEvent(
      CatagoryAddEvent event, Emitter<CategoryState> emit) async {
    log('message');
    emit(CategoryAddingState());
    if (catagoryFull.contains(event.category.toLowerCase())) {
      emit(CategoryErrorState(error: 'this category already exists'));
    } else {
      emit(CategoryLoadingState());
      try {
        await CategoryDatabaseServices().addCategory(event.category);
        catagoryFull.add(event.category);
        catagory.add(event.category);
        emit(CategoryLoadedState());
      } on FirebaseException catch (e) {
        log(e.code.toString());
      }
    }
  }
}
