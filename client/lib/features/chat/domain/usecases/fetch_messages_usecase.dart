import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/domain/repository/chat_repo.dart';
import 'package:client/services/service_locator.dart';
import 'package:dartz/dartz.dart';

class FetchMessagesUsecase implements Usecase<Either<String, List<MessageModel>>, FetchMessagesParams> {
  @override
  Future<Either<String, List<MessageModel>>> call({required FetchMessagesParams param}) {
    return sl<ChatRepository>().fetchMessages(param);
  }
}