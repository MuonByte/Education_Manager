import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/domain/repository/chat_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class CreateChatRoomUsecase implements Usecase<Either<String, ChatRoomModel>, CreateChatRoomParams> {
  @override
  Future<Either<String, ChatRoomModel>> call({required CreateChatRoomParams param}) {
    return sl<ChatRepository>().createRoom(param);
  }
}