import 'package:client/features/auth/data/repository/auth_repo_impl.dart';
import 'package:client/features/auth/data/source/auth_api_service.dart';
import 'package:client/features/auth/data/source/auth_local_service.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/features/auth/domain/usecases/get_user.dart';
import 'package:client/features/auth/domain/usecases/is_auth_usecase.dart';
import 'package:client/features/auth/domain/usecases/login_usecase.dart';
import 'package:client/features/auth/domain/usecases/logout_usecase.dart';
import 'package:client/features/auth/domain/usecases/signup_usecase.dart';

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

}