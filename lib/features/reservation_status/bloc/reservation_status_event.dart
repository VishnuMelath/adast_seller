part of 'reservation_status_bloc.dart';

@immutable
sealed class ReservationStatusEvent {}

class ReservationTileLoadingEvent extends ReservationStatusEvent{
  final String itemId;
  final String userId;

  ReservationTileLoadingEvent({required this.itemId, required this.userId});
}

class ReservationRelodEvent extends ReservationStatusEvent{}

class ReservationMarkAsSoldEvent extends ReservationStatusEvent{}