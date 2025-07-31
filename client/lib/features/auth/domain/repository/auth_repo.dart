import 'package:client/features/auth/data/model/send_otp_request.dart';
import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/data/model/register_request.dart';
import 'package:client/features/auth/data/model/reset_password_requset.dart';
import 'package:client/features/auth/data/model/verify_otp_request.dart';

import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupRequestParameters signupReq);
  Future<Either> login(LoginRequestParameters loginReq);
  Future<bool> isAuth(); 
  Future<Either> getUser();
  Future logout();
  Future<Either> sendOtp(SendOtpRequestParameters otpReq);
  Future<Either> resetPassword(ResetPasswordRequestParameters param);
  Future<Either> verifyOtp(VerifyOtpRequest param);
  Future<Either> requestOtp(SendOtpRequestParameters otpReq);
}