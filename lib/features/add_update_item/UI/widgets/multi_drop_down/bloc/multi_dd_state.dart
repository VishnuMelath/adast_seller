part of 'multi_dd_bloc.dart';

@immutable
sealed class MultiDdState {}

final class MultiDdInitial extends MultiDdState {}

class MultiDdOptionChangedState extends MultiDdState{}
