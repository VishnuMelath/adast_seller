part of 'chat_list_bloc.dart';

@immutable
sealed class ChatListEvent {}

class ChatListLoadingEvent extends ChatListEvent{
  final String sellerId;

  ChatListLoadingEvent({required this.sellerId});
}

class ChatListTileLoadingEvent extends ChatListEvent{
  final String userId;

  ChatListTileLoadingEvent({required this.userId});
}