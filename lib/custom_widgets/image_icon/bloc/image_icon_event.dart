part of 'image_icon_bloc.dart';

@immutable
abstract class ImageIconEvent {}

class ImageIconPressedEvent extends ImageIconEvent{}

class CameraIconPressedEvent extends ImageIconEvent{}

class GalaryIconPressedEvent extends ImageIconEvent{}


