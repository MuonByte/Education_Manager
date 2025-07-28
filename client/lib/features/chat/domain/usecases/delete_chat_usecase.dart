import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/domain/repository/chat_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class DeleteChatRoomUsecase implements Usecase<Either<String, String>, DeleteChatRoomParams> {
  @override
  Future<Either<String, String>> call({required DeleteChatRoomParams param}) {
    return sl<ChatRepository>().deleteRoom(param);
  }
}
