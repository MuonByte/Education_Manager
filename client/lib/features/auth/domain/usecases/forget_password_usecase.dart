import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/data/model/forget_password_request.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class ForgetPasswordUsecase implements Usecase<Either, ForgetPasswordRequestParameters> {
  @override
  Future<Either> call({required ForgetPasswordRequestParameters param}) {
    return sl<AuthRepository>().forgetPassword(param);
  }
}