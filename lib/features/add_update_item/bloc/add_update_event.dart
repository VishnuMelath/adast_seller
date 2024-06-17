part of 'add_update_bloc.dart';

@immutable
sealed class AddUpdateEvent {}

class SaveButtonPressedEvent extends AddUpdateEvent{
  final GlobalKey<FormState> formkey ;

  SaveButtonPressedEvent({required this.formkey});
}