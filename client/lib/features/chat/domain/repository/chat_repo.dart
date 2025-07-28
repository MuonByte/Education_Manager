import 'package:client/features/chat/data/model/chat_parameters.dart';

import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<String, ChatRoomModel>> createRoom(CreateChatRoomParams params);
  Future<Either<String, List<ChatRoomModel>>> fetchRooms(FetchChatRoomsParams params);
  Future<Either<String, MessageModel>> sendMessage(SendMessageParams params);
  Future<Either<String, List<MessageModel>>> fetchMessages(FetchMessagesParams params);
}
