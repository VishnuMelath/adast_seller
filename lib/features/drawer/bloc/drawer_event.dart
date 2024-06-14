part of 'drawer_bloc.dart';

@immutable
sealed class DrawerEvent {}

class DrawerLogoutPressedEvent extends DrawerEvent{}

class DrawerOptionTappedEvent extends DrawerEvent{
  final int index;
  DrawerOptionTappedEvent({required this.index});
}