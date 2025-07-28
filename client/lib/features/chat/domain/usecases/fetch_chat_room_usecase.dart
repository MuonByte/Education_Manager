import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/domain/repository/chat_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class FetchChatRoomsUsecase implements Usecase<Either<String, List<ChatRoomModel>>, FetchChatRoomsParams> {
  @override
  Future<Either<String, List<ChatRoomModel>>> call({required FetchChatRoomsParams param}) {
    return sl<ChatRepository>().fetchRooms(param);
  }
}
