part of 'image_icon_bloc.dart';


@immutable
abstract class ImageIconEvent {}

class ImageIconPressedEvent extends ImageIconEvent{
  
}

class CameraIconPressedEvent extends ImageIconEvent{
  final String email;
  final BuildContext context;

  CameraIconPressedEvent({required this.email,required this.context});


}

class GalaryIconPressedEvent extends ImageIconEvent{
  final String email;final BuildContext context;

  GalaryIconPressedEvent({required this.email,required this.context});
}


