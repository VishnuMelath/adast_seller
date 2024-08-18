part of 'openmap_bloc.dart';

@immutable
sealed class OpenmapEvent {}
class MapTapedEvent extends OpenmapEvent {
  final LatLng latLng;

  MapTapedEvent({required this.latLng});
}
class MapCurrentLocationTappedEvent extends OpenmapEvent{
  final MapController mapController;

  MapCurrentLocationTappedEvent({required this.mapController});
}

class MapSavePressedEvent extends OpenmapEvent {
final GlobalKey<FormState> formkey;
 final String name;
 final LatLng latLng;
 final String? image;
 final String email;
 final String place;
  MapSavePressedEvent({required this.place,required this.name, required this.latLng, required this.image,required this.email,required this.formkey});
}
