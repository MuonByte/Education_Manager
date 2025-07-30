import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/data/sources/chat_api_service.dart';
import 'package:client/features/chat/domain/repository/chat_repo.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatApiService _chatApiService;

  ChatRepositoryImpl(this._chatApiService);

  @override
  Future<Either<String, ChatRoomModel>> createRoom(CreateChatRoomParams params) async {
    final result = await _chatApiService.createRoom(params);
    return result.fold(
      (err) => Left(err),
      (data) {
        final model = ChatRoomModel(
          roomName: data['roomName'],
          roomId: data['roomId'],
        );
        return Right(model);
      },
    );
  }

  @override
  Future<Either<String, List<ChatRoomModel>>> fetchRooms(FetchChatRoomsParams params) async {
    final result = await _chatApiService.fetchRooms(params);
    return result.fold(
      (err) => Left(err),
      (list) {
        final rooms = list.map((e) => ChatRoomModel(
          roomName: e['roomName'],
          roomId: e['roomId'],
        )).toList();
        return Right(rooms);
      },
    );
  }

  @override
  Future<Either<String, List<MessageModel>>> fetchMessages(FetchMessagesParams params) async {
    try {
      final messages = await _chatApiService.fetchMessages(params.roomId);
      return Right(messages);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Failed to fetch messages');
    }
  }

  @override
  Future<Either<String, MessageModel>> sendMessage(SendMessageParams params) async {
    try {
      final message = await _chatApiService.sendMessage(params);
      return Right(message);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Failed to send message');
    }
  }

  @override
  Future<Either<String, String>> deleteRoom(DeleteChatRoomParams params) async {
    final result = await _chatApiService.deleteRoom(params);
    return result.fold(
      (err) => Left(err),
      (message) => Right(message),
    );
  }

}
