part of 'wallet_bloc.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

class WalletTransactionsLoadingState extends WalletState{}

class WalletTransactionsLoadedState extends WalletState{}

class WalletErrorState extends WalletState{}

class WalletWithdrawCompletedState extends WalletState{}