import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/data/model/reset_password_requset.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class ResetPasswordUsecase implements Usecase<Either, ResetPasswordRequestParameters> {
  @override
  Future<Either> call({required ResetPasswordRequestParameters param}) {
    return sl<AuthRepository>().resetPassword(param);
  }
}
