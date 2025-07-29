import 'package:client/features/chat/data/model/chat_parameters.dart';

import 'package:equatable/equatable.dart';

abstract class ChatRoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchChatRoomsEvent extends ChatRoomEvent {}

class CreateChatRoomEvent extends ChatRoomEvent {
  final CreateChatRoomParams params;
  CreateChatRoomEvent(this.params);
}

class DeleteChatRoomEvent extends ChatRoomEvent {
  final String roomId;
  DeleteChatRoomEvent(this.roomId);
}

class SendMessageEvent extends ChatRoomEvent {
  final SendMessageParams params;
  SendMessageEvent(this.params);
}

class FetchMessagesEvent extends ChatRoomEvent {
  final String roomId;
  FetchMessagesEvent({required this.roomId});
}
