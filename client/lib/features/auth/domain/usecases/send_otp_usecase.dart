import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/data/model/send_otp_request.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';

class SendOtpUsecase implements Usecase<Either, SendOtpRequestParameters> {
  @override
  Future<Either> call({required SendOtpRequestParameters param}) {
    return sl<AuthRepository>().sendOtp(param);
  }
}