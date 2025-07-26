import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/data/model/verify_otp_request.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class VerifyotpUsecase implements Usecase<Either, VerifyOtpRequest> {
  @override
  Future<Either> call({required VerifyOtpRequest param}) {
    return sl<AuthRepository>().verifyOtp(param);
  }
}