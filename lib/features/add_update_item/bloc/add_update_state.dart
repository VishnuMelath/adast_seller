part of 'add_update_bloc.dart';

@immutable
sealed class AddState {}

final class AddInitial extends AddState {}

class SaveButtonPressedState extends AddState{}

class NetworkErrorState extends AddState{}

class AddNotCompletedState extends AddState{
  final String message;

  AddNotCompletedState({required this.message});
}

class AddUpadateSavedSuccessState extends AddState{}