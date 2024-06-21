part of 'update_item_bloc.dart';

@immutable
sealed class UpdateItemEvent {}

class UpdateButtonClickedEvent extends UpdateItemEvent{
  final GlobalKey<FormState> formkey;

  UpdateButtonClickedEvent({required this.formkey});
}

