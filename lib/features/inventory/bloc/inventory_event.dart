part of 'inventory_bloc.dart';

@immutable
sealed class InventoryEvent {}

class InventoryInitialEvent extends InventoryEvent{}

class InventoryAddButtonPressedEvent extends InventoryEvent{}

class InventoryPressedOnItemEvent extends InventoryEvent{}

class InventorySearchPressedEvent extends InventoryEvent{}

