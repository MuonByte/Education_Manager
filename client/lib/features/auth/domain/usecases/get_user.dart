import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class GetUserUsecase implements Usecase<Either, dynamic>{

  @override
  Future<Either> call({dynamic param}) async {
    return sl<AuthRepository>().getUser();
  }

}