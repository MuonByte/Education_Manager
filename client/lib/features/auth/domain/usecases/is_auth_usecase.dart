import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

class IsAuthUsecase implements Usecase<bool, dynamic>{

  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepository>().isAuth();
  }


}