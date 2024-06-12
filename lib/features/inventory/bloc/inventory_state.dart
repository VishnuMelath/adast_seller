part of 'inventory_bloc.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {}

abstract class InventoryActionState extends InventoryState{}

class InventoryLoadingState extends InventoryState{}