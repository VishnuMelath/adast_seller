part of 'multi_dd_bloc.dart';

@immutable
sealed class MultiDdEvent {}

class MultiDdSelectedEvent extends MultiDdEvent{
  final List<String> sized;

  MultiDdSelectedEvent({required this.sized});
}

class MultiDdUnSelectedEvent extends MultiDdEvent{
  final String size;

  MultiDdUnSelectedEvent({required this.size});
}

