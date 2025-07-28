import 'package:client/features/chat/domain/usecases/delete_chat_usecase.dart';
import 'package:client/features/chat/viewmodel/bloc/chat_room_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  final DeleteChatRoomUsecase deleteChatRoomUsecase;

  ChatRoomCubit({required this.deleteChatRoomUsecase}) : super(ChatRoomInitial());

  Future<void> deleteRoom(String roomId) async {
    emit(ChatRoomLoading());
    final result = await deleteChatRoomUsecase(param: DeleteChatRoomParams(roomId: roomId));

    result.fold(
      (error) => emit(ChatRoomError(error)),
      (message) => emit(ChatRoomSuccess(message)),
    );
  }
}
