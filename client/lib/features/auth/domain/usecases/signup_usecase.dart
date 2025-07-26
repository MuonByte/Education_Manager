import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/data/model/register_request.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class SignupUsecases implements Usecase<Either, SignupRequestParameters>{

  @override
  Future<Either> call({required SignupRequestParameters param}) async {
    return sl<AuthRepository>().signup(param);
  }
}