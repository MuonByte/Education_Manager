import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/domain/usecases/create_chat_usecase.dart';
import 'package:client/features/chat/domain/usecases/delete_chat_usecase.dart';
import 'package:client/features/chat/domain/usecases/fetch_chat_room_usecase.dart';
import 'package:client/features/chat/viewmodel/bloc/chat_room/chat_room_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomViewModel extends Cubit<ChatRoomState> {
  final FetchChatRoomsUsecase fetchChatRoomsUsecase;
  final CreateChatRoomUsecase createChatRoomUsecase;
  final DeleteChatRoomUsecase deleteChatRoomUsecase;

  List<ChatRoomModel> _chatRooms = [];
  List<ChatRoomModel> get chatRooms => _chatRooms;

  ChatRoomViewModel({
    required this.fetchChatRoomsUsecase,
    required this.createChatRoomUsecase,
    required this.deleteChatRoomUsecase,
  }) : super(ChatRoomInitial());

  Future<void> getRooms() async {
    emit(ChatRoomLoading());
    final result = await fetchChatRoomsUsecase(param: FetchChatRoomsParams());

    result.fold(
      (error) => emit(ChatRoomError(error)),
      (rooms) {
        _chatRooms = rooms;
        emit(ChatRoomLoaded(rooms));
      },
    );
  }

  Future<void> createRoom(String name) async {
    emit(ChatRoomLoading());
    final result = await createChatRoomUsecase(param: CreateChatRoomParams(roomName: name));

    result.fold(
      (error) => emit(ChatRoomError(error)),
      (room) {
        _chatRooms.add(room);
        emit(ChatRoomLoaded(_chatRooms));
      },
    );
  }

  Future<void> deleteRoom(String roomId) async {
    emit(ChatRoomLoading());
    final result = await deleteChatRoomUsecase(param: DeleteChatRoomParams(roomId: roomId));

    result.fold(
      (error) => emit(ChatRoomError(error)),
      (message) {
        _chatRooms.removeWhere((room) => room.roomId == roomId);
        emit(ChatRoomLoaded(_chatRooms));
      },
    );
  }
}
