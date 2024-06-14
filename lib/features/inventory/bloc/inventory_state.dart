part of 'inventory_bloc.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {}

abstract class InventoryActionState extends InventoryState{}

class InventoryLoadingState extends InventoryState{}

class InventoryLoadedState extends InventoryState{}

class InventorySearchInitiatedState extends InventoryState{}

class InventorySearchCompletedState extends InventoryState{
  final List<ClothModel> searchlist;
InventorySearchCompletedState({required this.searchlist});
}

class InventoryEmptyState extends InventoryState{}

class InventoryNavigateToAddItemState extends InventoryActionState{}