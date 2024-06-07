part of 'image_icon_bloc.dart';

@immutable
sealed class ImageIconState {}

abstract class ImageIconActionState extends ImageIconState{}

class ImageIconShowBottomSheetState extends ImageIconActionState{}

final class ImageIconInitial extends ImageIconState {}

class ImageIconChangedState extends ImageIconState{}

class NoImageState extends ImageIconState{}

class ImagePickErrorState extends ImageIconState{}