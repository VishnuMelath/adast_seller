part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

class MapTapedEvent extends MapEvent {
  final LatLng latLng;

  MapTapedEvent({required this.latLng});
}
class MapCurrentLocationTappedEvent extends MapEvent{
  final GoogleMapController googleMapController;

  MapCurrentLocationTappedEvent({required this.googleMapController});
}

class MapSavePressedEvent extends MapEvent {
final GlobalKey<FormState> formkey;
 final String name;
 final LatLng latLng;
 final String? image;
 final String email;
 final String place;
  MapSavePressedEvent({required this.place,required this.name, required this.latLng, required this.image,required this.email,required this.formkey});
}
