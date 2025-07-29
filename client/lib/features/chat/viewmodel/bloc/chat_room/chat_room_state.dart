import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:equatable/equatable.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState();

  @override
  List<Object?> get props => [];
}

class ChatRoomInitial extends ChatRoomState {}

class ChatRoomLoading extends ChatRoomState {}

class ChatRoomSuccess extends ChatRoomState {
  final String message;

  const ChatRoomSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatRoomError extends ChatRoomState {
  final String error;

  const ChatRoomError(this.error);

  @override
  List<Object?> get props => [error];
}

class ChatRoomLoaded extends ChatRoomState {
  final List<ChatRoomModel> rooms;

  const ChatRoomLoaded(this.rooms);

  @override
  List<Object?> get props => [rooms];
}
