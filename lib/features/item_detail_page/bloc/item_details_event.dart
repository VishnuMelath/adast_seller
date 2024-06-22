part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsEvent {}

class ItemDetailsChangedEvent extends ItemDetailsEvent {
  final ClothModel item;

  ItemDetailsChangedEvent({required this.item});
}

class ItemDetailsSizeChangedEvent extends ItemDetailsEvent {
  final String size;

  ItemDetailsSizeChangedEvent({required this.size});
}
