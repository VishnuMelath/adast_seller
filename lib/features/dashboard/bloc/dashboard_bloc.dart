import 'dart:async';
import 'package:adast_seller/models/reservation_model.dart';
import 'package:adast_seller/services/reservation_databaase_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  List<ReservationModel> reservaions = [];
  DateTime chartEndDate  =DateTime.now();
  int maxy = 0;
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialEvent>(dashboardInitialEvent);
  }

  FutureOr<void> dashboardInitialEvent(
      DashboardInitialEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());
    reservaions =
        await ReservationDatabaseServices().loadReservations(event.sellerId);
    emit(DashboardLoadedState());
  }
}

DateTime switchMonths(DateTime date,int months) {
  var month = date.month;
  var year = date.year;
  var temp = month ~/ months;
  if (temp == 0) {
    year--;
  }
  month = (month - months) % 12;
  return DateTime(year, month);
}
