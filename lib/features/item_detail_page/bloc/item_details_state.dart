part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsState {}

final class ItemDetailsInitial extends ItemDetailsState {}

class ItemDetailsChangedState extends ItemDetailsState{
  final ClothModel item;

  ItemDetailsChangedState({required this.item});

}

class ItemDetailsSizeChangedState extends ItemDetailsState{}

class ItemDetailsPageChangedState extends ItemDetailsState{}