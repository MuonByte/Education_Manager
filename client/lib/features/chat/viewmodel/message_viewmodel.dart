import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/viewmodel/bloc/messages/message_cubit.dart';

class MessagesViewModel {
  final MessagesCubit messagesCubit;

  MessagesViewModel(this.messagesCubit);

  void fetchMessages(String roomId) {
    messagesCubit.fetchMessages(FetchMessagesParams(roomId: roomId));
  }

  void sendMessage(SendMessageParams params) {
    messagesCubit.sendMessage(params);
  }
}
