import 'dart:async';
import 'dart:developer';

import 'package:adast_seller/models/seller_model.dart';
import 'package:adast_seller/services/user_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<MapTapedEvent>(mapTapedEvent);
    on<MapSavePressedEvent>(mapSavePressedEvent);
    on<MapCurrentLocationTappedEvent>(mapCurrentLocationTappedEvent);
  }

  FutureOr<void> mapTapedEvent(MapTapedEvent event, Emitter<MapState> emit) {
    emit(MapMarkerShowState(
        marker: Marker(markerId: const MarkerId('1'), position: event.latLng)));
    emit(MapBottomSheetState(latLng:  event.latLng));
  }

  FutureOr<void> mapSavePressedEvent(
      MapSavePressedEvent event, Emitter<MapState> emit) async{
        if(event.image==null)
        {
          emit(MapFormImageNotAddedState());
        }
        else{
          if(event.formkey.currentState!.validate())
          {
            try
            {
              var sellerModel=SellerModel(name: event.name, email: event.email,image: event.image,latLng: event.latLng);
             await DatabaseServices().addSeller(
                sellerModel
              ).then((_) {
                log('success');
                emit(MapNavigateToHomeState(sellerModel: sellerModel));
              },);
            }
            on FirebaseException catch (e)
            {
              emit(MapSaveErrorState(error: e.code.toString()));
            }
          }
        }
      }

  FutureOr<void> mapCurrentLocationTappedEvent(MapCurrentLocationTappedEvent event, Emitter<MapState> emit) async{
    var locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var zoom = await event.googleMapController.getZoomLevel();
    event.googleMapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: zoom)));
  }
}


