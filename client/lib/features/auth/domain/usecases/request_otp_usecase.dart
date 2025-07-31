import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/data/model/send_otp_request.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';

import 'package:dartz/dartz.dart';

class RequestOtpUsecase implements Usecase<Either, SendOtpRequestParameters> {
  final AuthRepository repo;
  RequestOtpUsecase(this.repo);
  @override
  Future<Either> call({required SendOtpRequestParameters param}) {
    return repo.requestOtp(param);
  }
}