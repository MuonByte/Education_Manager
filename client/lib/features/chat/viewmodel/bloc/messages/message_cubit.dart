import 'package:client/features/chat/domain/usecases/fetch_messages_usecase.dart';
import 'package:client/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/viewmodel/bloc/messages/message_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final FetchMessagesUsecase fetchMessagesUsecase;
  final SendMessageUsecase sendMessageUsecase;

  MessagesCubit({
    required this.fetchMessagesUsecase,
    required this.sendMessageUsecase,
  }) : super(MessagesInitial());

  Future<void> fetchMessages(FetchMessagesParams params) async {
    emit(MessagesLoading());

    final result = await fetchMessagesUsecase(param: params);

    result.fold(
      (error) => emit(MessagesError(error)),
      (messages) => emit(MessagesLoaded(messages: messages)),
    );
  }

  Future<void> sendMessage(SendMessageParams params) async {
    final result = await sendMessageUsecase(param: params);

    result.fold(
      (error) => emit(MessagesError(error)),
      (message) {
        final currentState = state;
        if (currentState is MessagesLoaded) {
          final updatedMessages = List<MessageModel>.from(currentState.messages)
            ..add(message);
          emit(MessagesLoaded(messages: updatedMessages));
        } else {
          emit(MessagesLoaded(messages: [message]));
        }
      },
    );
  }
}
