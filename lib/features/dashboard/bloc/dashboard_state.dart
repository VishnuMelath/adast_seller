part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

class DashboardLoadingState extends DashboardState{}
class DashboardLoadedState extends DashboardState{}
