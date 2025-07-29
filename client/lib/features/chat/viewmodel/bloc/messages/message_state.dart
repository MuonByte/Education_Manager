import 'package:client/features/chat/data/model/chat_parameters.dart';

import 'package:equatable/equatable.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object?> get props => [];
}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<MessageModel> messages;

  const MessagesLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class MessagesError extends MessagesState {
  final String error;

  const MessagesError(this.error);

  @override
  List<Object?> get props => [error];
}

class MessageSent extends MessagesState {
  final MessageModel message;

  const MessageSent(this.message);

  @override
  List<Object?> get props => [message];
}
