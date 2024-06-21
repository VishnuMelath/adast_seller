part of 'add_update_bloc.dart';

@immutable
sealed class AddEvent {}

class SaveButtonPressedEvent extends AddEvent{
  final GlobalKey<FormState> formkey ;

  SaveButtonPressedEvent({required this.formkey});
}