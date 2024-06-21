part of 'update_item_bloc.dart';

@immutable
sealed class UpdateItemState {}

final class UpdateItemInitial extends UpdateItemState {}


 class UpdateSuccesState extends UpdateItemState{}

class UpdateErrorState extends UpdateItemState{
  final String error;

  UpdateErrorState({required this.error});
}