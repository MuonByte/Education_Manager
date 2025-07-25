import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

class LogoutUsecase implements Usecase<dynamic, dynamic>{

  @override
  Future call({dynamic param}) async {
    await sl<AuthRepository>().logout();
  }

}