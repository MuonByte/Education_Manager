import 'package:client/features/auth/data/repository/auth_repo_impl.dart';
import 'package:client/features/auth/data/source/auth_api_service.dart';
import 'package:client/features/auth/data/source/auth_local_service.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:client/features/auth/domain/usecases/get_user.dart';
import 'package:client/features/auth/domain/usecases/is_auth_usecase.dart';
import 'package:client/features/auth/domain/usecases/login_usecase.dart';
import 'package:client/features/auth/domain/usecases/logout_usecase.dart';
import 'package:client/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:client/features/auth/domain/usecases/signup_usecase.dart';
import 'package:client/features/auth/domain/usecases/verifyotp_usecase.dart';
import 'package:client/features/chat/data/repository/chat_repo_impl.dart';
import 'package:client/features/chat/data/sources/chat_api_service.dart';
import 'package:client/features/chat/domain/repository/chat_repo.dart';
import 'package:client/features/chat/domain/usecases/create_chat_usecase.dart';
import 'package:client/features/chat/domain/usecases/delete_chat_usecase.dart';
import 'package:client/features/chat/domain/usecases/fetch_chat_room_usecase.dart';
import 'package:client/features/chat/domain/usecases/fetch_messages_usecase.dart';
import 'package:client/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:client/features/chat/viewmodel/chat_room_viewmodel.dart';

import 'package:get_it/get_it.dart';
import 'package:client/core/network/dio_client.dart';

final sl = GetIt.instance;

void setupServiceLocator() {

  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<AuthApiService>(
    AuthApiServiceImplementation()
  );

  sl.registerSingleton<AuthLocalService>(
    AuthLocalServiceImplementation()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImplementation()
  );

  sl.registerSingleton<SignupUsecases>(
    SignupUsecases()
  );

  sl.registerSingleton<IsAuthUsecase>(
    IsAuthUsecase()
  );

  sl.registerSingleton<GetUserUsecase>(
    GetUserUsecase()
  );

  sl.registerSingleton<LogoutUsecase>(
    LogoutUsecase()
  );

  sl.registerSingleton<LoginUsecase>(
    LoginUsecase()
  );

  sl.registerSingleton<ForgetPasswordUsecase>(
    ForgetPasswordUsecase()
  );

  sl.registerSingleton<ResetPasswordUsecase>(
    ResetPasswordUsecase()
  );

  sl.registerSingleton<VerifyotpUsecase>(
    VerifyotpUsecase()
  );

  sl.registerSingleton<ChatApiService>(
    ChatApiServiceImpl(sl<DioClient>())
  );
  
  sl.registerSingleton<ChatRepository>(
    ChatRepositoryImpl(sl<ChatApiService>())
  );

  sl.registerSingleton<CreateChatRoomUsecase>(
    CreateChatRoomUsecase()
  );
  
  sl.registerSingleton<FetchChatRoomsUsecase>(
    FetchChatRoomsUsecase()
  );
  
  sl.registerSingleton<SendMessageUsecase>(
    SendMessageUsecase()
  );
  
  sl.registerSingleton<FetchMessagesUsecase>(
    FetchMessagesUsecase()
  );

  sl.registerSingleton<DeleteChatRoomUsecase>(
    DeleteChatRoomUsecase()
  );

  sl.registerFactory(
    () => ChatRoomViewModel(
      fetchChatRoomsUsecase: sl<FetchChatRoomsUsecase>(),
      createChatRoomUsecase: sl<CreateChatRoomUsecase>(),
      deleteChatRoomUsecase: sl<DeleteChatRoomUsecase>(),
    ),
  );
}