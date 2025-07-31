import 'package:client/core/constants/api_urls.dart';
import 'package:client/core/network/dio_client.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/services/service_locator.dart';

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
      final response = await _client.get(
        ApiUrls.chatroomURL, 
      );
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
      ApiUrls.getMesByRoomIdURL.replaceFirst(':id', params.roomId),
      data: params.toMap(),
    );
    return MessageModel.fromJson(response.data);
  }

  @override
  Future<List<MessageModel>> fetchMessages(String roomId) async {
    final resp = await _client.get(
      ApiUrls.messagesURL.replaceFirst(':id', roomId),
    );
    
    if (resp.statusCode == 200) {
      final data = resp.data;
      List<dynamic> rawList;

      if (data is List) {
        rawList = data;
      } else if (data is Map<String, dynamic> && data['messages'] is List) {
        rawList = data['messages'] as List;
      } else {
        if (data is Map<String, dynamic> && (data.containsKey('userMessage') || data.containsKey('AIMessage'))) {
          return [MessageModel.fromJson(data)];
        }
        throw FormatException(
          'Expected a JSON list or a {"messages": [...]}, got ${data.runtimeType}'
        );
      }

      return rawList
        .cast<Map<String, dynamic>>()
        .map((json) => MessageModel.fromJson(json))
        .toList();
    }

    if (resp.statusCode == 404) return [];
    final msg = (resp.data is Map) ? resp.data['message'] as String? : null;
    throw DioException(
      requestOptions: resp.requestOptions,
      response: resp,
      message: msg ?? 'Unexpected HTTP ${resp.statusCode}'
    );
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