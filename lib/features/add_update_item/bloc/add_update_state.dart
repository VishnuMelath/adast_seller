part of 'add_update_bloc.dart';

@immutable
sealed class AddUpdateState {}

final class AddUpdateInitial extends AddUpdateState {}

class SaveButtonPressedState extends AddUpdateState{}

class NetworkErrorState extends AddUpdateState{}

class AddUpdateNotCompletedState extends AddUpdateState{
  final String message;

  AddUpdateNotCompletedState({required this.message});
}

class AddUpadateSavedSuccessState extends AddUpdateState{}