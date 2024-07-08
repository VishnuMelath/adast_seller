part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class CategorySearchEvent  extends CategoryEvent{
  final String query;

  CategorySearchEvent({required this.query});
}

class CategoryInitialEvent extends CategoryEvent{}

class CategorySelectedEvent extends CategoryEvent{
  final String? category;

  CategorySelectedEvent({required this.category});
}

class CatagoryAddEvent extends CategoryEvent{
  final String category;

  CatagoryAddEvent({required this.category});
}