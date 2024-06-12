part of 'inventory_bloc.dart';

@immutable
sealed class InventoryEvent {}

class InventoryInitialEvent extends InventoryEvent{}

