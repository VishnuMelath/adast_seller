part of 'revenue_bloc.dart';

@immutable
sealed class RevenueState {}

final class RevenueInitial extends RevenueState {}

class RevenueLoadingState extends RevenueState{}

class RevenueLoadedState extends RevenueState{}
