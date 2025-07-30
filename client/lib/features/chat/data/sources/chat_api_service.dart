import 'package:client/core/constants/api_urls.dart';
import 'package:client/core/network/dio_client.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ChatApiService {
  Future<Either<String, Map<String, dynamic>>> createRoom(CreateChatRoomParams params);
  Future<Either<String, List<Map<String, dynamic>>>> fetchRooms(FetchChatRoomsParams params);
  Future<List<MessageModel>> fetchMessages(String roomId);
  Future<MessageModel> sendMessage(SendMessageParams params);
  Future<Either<String, String>> deleteRoom(DeleteChatRoomParams params); 
}

class ChatApiServiceImpl extends ChatApiService {
  final DioClient _client;

  ChatApiServiceImpl(this._client);

  @override
  Future<Either<String, Map<String, dynamic>>> createRoom(CreateChatRoomParams params) async {
    try {
      final response = await _client.post(ApiUrls.createRoomsURL, data: params.toMap());
      return Right(response.data);
    } 
    
    on DioException catch (e) {
      final err = e.response?.data['message'] ?? e.message;
      return Left(err);
    }
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> fetchRooms(FetchChatRoomsParams params) async {
    try {
      final response = await _client.get(ApiUrls.chatroomURL, queryParameters: params.toMap());
      final list = List<Map<String, dynamic>>.from(response.data);
      return Right(list);
    } 
    
    on DioException catch (e) {
      final err = e.response?.data['message'] ?? e.message;
      return Left(err);
    }
  }

  @override
  Future<MessageModel> sendMessage(SendMessageParams params) async {
    final response = await _client.post(
      ApiUrls.messagesURL.replaceFirst(':id', params.roomId),
      data: params.toMap(),
    );
    return MessageModel.fromJson(response.data);
  }

  @override
  Future<List<MessageModel>> fetchMessages(String roomId) async {
    final response = await _client.get(ApiUrls.messagesURL.replaceFirst(':id', roomId));
    final List data = response.data;
    return data.map((json) => MessageModel.fromJson(json)).toList();
  }

  @override
  Future<Either<String, String>> deleteRoom(DeleteChatRoomParams params) async {
    try {
      final response = await _client.delete(
        ApiUrls.chatroomURL + '/' + params.roomId,
      );
      return Right(response.data['message'] ?? 'Room deleted');
    } 
    on DioException catch (e) {
      final err = e.response?.data['message'] ?? e.message;
      return Left(err);
    }
  }

}