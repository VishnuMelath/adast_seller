part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

class WalletTransactionsLoadingEvent extends WalletEvent{}

class WalletWithdrawPressedEvent extends WalletEvent{}