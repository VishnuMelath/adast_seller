part of 'revenue_bloc.dart';

@immutable
sealed class RevenueEvent {}

class RevenueTileLoadingEvent extends RevenueEvent{
  final String email;

  RevenueTileLoadingEvent({required this.email});
}


