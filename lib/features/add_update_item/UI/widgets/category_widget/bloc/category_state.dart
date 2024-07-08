part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState{}

class CategoryLoadedState extends CategoryState{}

class CategoryAddingState extends CategoryState{}

class CategoryAddedState extends CategoryState{}

class CategoryErrorState extends CategoryState{
  final String error;

  CategoryErrorState({required this.error});
}


