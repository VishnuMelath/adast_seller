part of 'itemimageadd_bloc.dart';

@immutable
sealed class ItemimageaddState {}

final class ItemimageaddInitial extends ItemimageaddState {}

class ItemListUpdatedState extends ItemimageaddState{}

class ItemImageUploadingState extends ItemimageaddState{
  final int count;

  ItemImageUploadingState({required this.count});
}

class ItemImageErrorState extends ItemimageaddState{
  final String error;

  ItemImageErrorState({required this.error});

}