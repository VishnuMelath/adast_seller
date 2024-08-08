import 'dart:async';

import 'package:adast_seller/models/cloth_model.dart';
import 'package:adast_seller/services/item_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'revenue_event.dart';
part 'revenue_state.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  int? totalRevenue;
  List<ClothModel> items=[];
  int sortOption=0;
  String querry='';
  RevenueBloc() : super(RevenueInitial()) {
    on<RevenueTileLoadingEvent>(revenueTileLoadingEvent);
  }

  FutureOr<void> revenueTileLoadingEvent(RevenueTileLoadingEvent event, Emitter<RevenueState> emit) async{
    emit(RevenueLoadingState());
  items=await ItemDatabaseServices().getAllItems(event.email);
  totalRevenue=0;
  for (var element in items) {
   totalRevenue=totalRevenue!+ element.revenue;
  }
  totalRevenue=totalRevenue!~/100;
  emit(RevenueLoadedState());
  }


}
