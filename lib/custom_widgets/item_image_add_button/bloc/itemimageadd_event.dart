part of 'itemimageadd_bloc.dart';

@immutable
sealed class ItemimageaddEvent {}

class ItemImagesAddPressedEvent extends ItemimageaddEvent{}

class ItemImageRemoveEvent extends ItemimageaddEvent{final String path;

  ItemImageRemoveEvent({required this.path});

}