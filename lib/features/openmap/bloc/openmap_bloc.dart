import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/seller_model.dart';
import '../../../services/seller_database_services.dart';

part 'openmap_event.dart';
part 'openmap_state.dart';

class OpenmapBloc extends Bloc<OpenmapEvent, OpenmapState> {
  OpenmapBloc() : super(OpenmapInitial()) {
    on<MapTapedEvent>(mapTapedEvent);
    on<MapSavePressedEvent>(mapSavePressedEvent);
    on<MapCurrentLocationTappedEvent>(mapCurrentLocationTappedEvent);
  }

  FutureOr<void> mapTapedEvent(
      MapTapedEvent event, Emitter<OpenmapState> emit) {
         emit(MapMarkerShowState(
        marker: Marker(child: Icon(Icons.location_history), point: event.latLng)));
    emit(MapBottomSheetState(latLng:  event.latLng));
      }

  FutureOr<void> mapSavePressedEvent(
      MapSavePressedEvent event, Emitter<OpenmapState> emit) async{
        if(event.image==null)
        {
          emit(MapFormImageNotAddedState());
        }
        else{
          if(event.formkey.currentState!.validate())
          {
            try
            {
              GeoPoint geoPoint=GeoPoint(event.latLng.latitude, event.latLng.longitude);
              var sellerModel=SellerModel(creationTime: DateTime.now(),name: event.name, email: event.email,image: event.image,latLng: geoPoint,place: event.place);
             await SellerDatabaseServices().addSeller(
                sellerModel
              ).then((_) {
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

  FutureOr<void> mapCurrentLocationTappedEvent(
      MapCurrentLocationTappedEvent event, Emitter<OpenmapState> emit) async{

         var locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // var zoom = await event.mapController.getZoomLevel();
    log(position.toString());
    emit(MapCurrentLoacationState(current:LatLng(position.latitude, position.longitude)));
    // event.mapController.move(LatLng(position.latitude, position.longitude),13.0);
  }
}

