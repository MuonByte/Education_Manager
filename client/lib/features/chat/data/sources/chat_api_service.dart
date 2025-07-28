import 'package:client/core/network/dio_client.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ChatApiService {
  Future<Either<String, Map<String, dynamic>>> createRoom(CreateChatRoomParams params);
  Future<Either<String, List<Map<String, dynamic>>>> fetchRooms(FetchChatRoomsParams params);
  Future<Either<String, Map<String, dynamic>>> sendMessage(SendMessageParams params);
  Future<Either<String, List<Map<String, dynamic>>>> fetchMessages(FetchMessagesParams params);
  Future<Either<String, String>> deleteRoom(DeleteChatRoomParams params); 
}

class ChatApiServiceImpl extends ChatApiService {
  final DioClient _client;

  ChatApiServiceImpl(this._client);

  @override
  Future<Either<String, Map<String, dynamic>>> createRoom(CreateChatRoomParams params) async {
    try {
      final response = await _client.post("/chat/rooms", data: params.toMap());
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
      final response = await _client.get("/chat/rooms");
      final list = List<Map<String, dynamic>>.from(response.data);
      return Right(list);
    } 
    
    on DioException catch (e) {
      final err = e.response?.data['message'] ?? e.message;
      return Left(err);
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> sendMessage(SendMessageParams params) async {
    try {
      FormData formData = FormData.fromMap({
        'text': params.messageText,
        if (params.imageFile != null)
          'image': await MultipartFile.fromFile(params.imageFile!.path,
              filename: params.imageFile!.path.split('/').last),
      });

      final response = await _client.post(
        "/chat/rooms/${params.roomId}/messages",
        data: formData,
      );

      return Right(response.data);
    } on DioException catch (e) {
      final err = e.response?.data['message'] ?? e.message;
      return Left(err);
    }
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> fetchMessages(FetchMessagesParams params) async {
    try {
      final response = await _client.get("/chat/rooms/${params.roomId}/messages");
      final list = List<Map<String, dynamic>>.from(response.data);
      return Right(list);
    } 
    
    on DioException catch (e) {
      final err = e.response?.data['message'] ?? e.message;
      return Left(err);
    }
  }

  @override
Future<Either<String, String>> deleteRoom(DeleteChatRoomParams params) async {
  try {
    final response = await _client.delete("/chat/rooms/${params.roomId}");
    return Right(response.data['message'] ?? 'Room deleted');
  } 
  
  on DioException catch (e) {
    final err = e.response?.data['message'] ?? e.message;
    return Left(err);
  }
}
}