import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/data/sources/chat_api_service.dart';
import 'package:client/features/chat/domain/repository/chat_repo.dart';

import 'package:dartz/dartz.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatApiService _apiService;

  ChatRepositoryImpl(this._apiService);

  @override
  Future<Either<String, ChatRoomModel>> createRoom(CreateChatRoomParams params) async {
    final result = await _apiService.createRoom(params);
    return result.fold(
      (err) => Left(err),
      (data) {
        final model = ChatRoomModel(
          newRoom: true,
          roomName: data['roomName'],
          roomId: data['roomId'],
        );
        return Right(model);
      },
    );
  }

  @override
  Future<Either<String, List<ChatRoomModel>>> fetchRooms(FetchChatRoomsParams params) async {
    final result = await _apiService.fetchRooms(params);
    return result.fold(
      (err) => Left(err),
      (list) {
        final rooms = list.map((e) => ChatRoomModel(
          newRoom: false,
          roomName: e['roomName'],
          roomId: e['roomId'],
        )).toList();
        return Right(rooms);
      },
    );
  }

  @override
  Future<Either<String, MessageModel>> sendMessage(SendMessageParams params) async {
    final result = await _apiService.sendMessage(params);
    return result.fold(
      (err) => Left(err),
      (data) {
        final msg = MessageModel(
          messageId: data['messageId'],
          messageText: data['text'],
        );
        return Right(msg);
      },
    );
  }

  @override
  Future<Either<String, List<MessageModel>>> fetchMessages(FetchMessagesParams params) async {
    final result = await _apiService.fetchMessages(params);
    return result.fold(
      (err) => Left(err),
      (list) {
        final msgs = list.map((e) => MessageModel(
          messageId: e['messageId'],
          messageText: e['text'],
        )).toList();
        return Right(msgs);
      },
    );
  }

  @override
  Future<Either<String, String>> deleteRoom(DeleteChatRoomParams params) async {
    final result = await _apiService.deleteRoom(params);
    return result.fold(
      (err) => Left(err),
      (message) => Right(message),
    );
  }

}
