import 'package:equatable/equatable.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object?> get props => [];
}

class FetchMessagesEvent extends MessagesEvent {
  final String roomId;
  const FetchMessagesEvent(this.roomId);
}

class SendMessageEvent extends MessagesEvent {
  final SendMessageParams params;
  const SendMessageEvent(this.params);
}
