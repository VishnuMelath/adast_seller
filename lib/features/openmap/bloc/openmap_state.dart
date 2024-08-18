part of 'openmap_bloc.dart';

@immutable
sealed class OpenmapState {}

final class OpenmapInitial extends OpenmapState {}


abstract class MapActionState extends OpenmapState{}

class MapBottomSheetState extends OpenmapState{
  final LatLng latLng;

  MapBottomSheetState({required this.latLng});
}

class MapMarkerShowState extends MapActionState{
  final Marker marker;

  MapMarkerShowState({required this.marker});

}

class MapNavigateToHomeState extends OpenmapState{
 final SellerModel sellerModel;

  MapNavigateToHomeState({required this.sellerModel});
}

class MapSaveErrorState extends OpenmapState{
 final String error;

  MapSaveErrorState({required this.error});
}

class MapFormImageNotAddedState extends MapActionState{}

class MapCurrentLoacationState extends MapActionState{
  final LatLng current;

  MapCurrentLoacationState({required this.current});
}
