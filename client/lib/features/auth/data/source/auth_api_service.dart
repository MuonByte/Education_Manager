import 'package:client/core/constants/api_urls.dart';
import 'package:client/features/auth/data/model/send_otp_request.dart';
import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/data/model/register_request.dart';
import 'package:client/features/auth/data/model/reset_password_requset.dart';
import 'package:client/features/auth/data/model/verify_otp_request.dart';
import 'package:client/services/service_locator.dart';
import 'package:client/core/network/dio_client.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupRequestParameters signupReq);
  Future<Either> getUser();
  Future<Either> login(LoginRequestParameters loginReq);
  Future<Either> sendOtp(SendOtpRequestParameters otpReq);
  Future<Either> resetPassword(ResetPasswordRequestParameters param);
  Future<Either> verifyOtp(VerifyOtpRequest param);
  Future<Either> requestOtp(SendOtpRequestParameters otpReq);
}

class AuthApiServiceImplementation extends AuthApiService {
  @override
  Future<Either> signup(SignupRequestParameters signupReq) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.registerURL,
        data: signupReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      final response = await sl<DioClient>().get(ApiUrls.userProfileURL);
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<Either> login(LoginRequestParameters loginReq) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.loginURL,
        data: loginReq.toMap(),
      );
      return Right(response);
    } 
    on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<Either> requestOtp(SendOtpRequestParameters otpReq) async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrls.gforgetPassURL,
        queryParameters: {'email': otpReq.value},
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<Either> sendOtp(SendOtpRequestParameters otpReq) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.gforgetPassURL,
        data: otpReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<Either> resetPassword(ResetPasswordRequestParameters param) async {
    try {
      final response = await sl<DioClient>().put(
        ApiUrls.resetPassURL,
        data: param.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<Either> verifyOtp(VerifyOtpRequest param) async {
    try {
      final response = await sl<DioClient>().put(
        ApiUrls.verifyOtpURL,
        data: param.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }
}
