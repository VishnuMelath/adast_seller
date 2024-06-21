part of 'inventory_bloc.dart';

@immutable
sealed class InventoryEvent {}

class InventoryInitialEvent extends InventoryEvent{
  final String email;
  InventoryInitialEvent({required this.email});
}

class InventoryAddButtonPressedEvent extends InventoryEvent{}

class InventoryPressedOnItemEvent extends InventoryEvent{}

class InventorySearchEvent extends InventoryEvent{
 final String searchQuery;

  InventorySearchEvent({required this.searchQuery});
}

// class InventorySortEvent extends InventoryEvent{
//   Map<String,String> 
// }

class InventoryFilterEvent extends InventoryEvent{}

