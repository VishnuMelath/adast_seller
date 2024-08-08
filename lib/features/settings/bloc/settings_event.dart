part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class SettingsEditUserSaveButtonPressedEvent extends SettingsEvent{
  final SellerModel sellerModel;

  SettingsEditUserSaveButtonPressedEvent({required this.sellerModel});
}