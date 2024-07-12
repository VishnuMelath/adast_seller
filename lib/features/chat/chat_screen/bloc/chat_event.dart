part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatSetSellerUnseenCountZero extends ChatEvent{}
