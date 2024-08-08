part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent{
  final String sellerId;

  DashboardInitialEvent({required this.sellerId});
}