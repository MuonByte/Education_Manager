import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/domain/repository/chat_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class SendMessageUsecase implements Usecase<Either<String, MessageModel>, SendMessageParams> {
  @override
  Future<Either<String, MessageModel>> call({required SendMessageParams param}) {
    return sl<ChatRepository>().sendMessage(param);
  }
}
