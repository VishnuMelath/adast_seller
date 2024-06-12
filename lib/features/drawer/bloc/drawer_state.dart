part of 'drawer_bloc.dart';

@immutable
sealed class DrawerState {}

final class DrawerInitial extends DrawerState {}

abstract class DrawerActionState extends DrawerState{}

class DrawerLogoutPressedState extends DrawerActionState{}
