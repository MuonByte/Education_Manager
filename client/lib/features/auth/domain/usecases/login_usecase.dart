import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class LoginUsecase implements Usecase<Either, LoginRequestParameters>{

  @override
  Future<Either> call({required LoginRequestParameters param}) async {
    return sl<AuthRepository>().login(param);
  }
}