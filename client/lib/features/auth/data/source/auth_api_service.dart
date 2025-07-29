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
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupRequestParameters signupReq);
  Future<Either> getUser();
  Future<Either> login(LoginRequestParameters loginReq);
  Future<Either> sendOtp(SendOtpRequestParameters otpReq);
  Future<Either> resetPassword(ResetPasswordRequestParameters param);
  Future<Either> verifyOtp(VerifyOtpRequest param);
} 

class AuthApiServiceImplementation extends AuthApiService {
  @override
  Future<Either> signup(SignupRequestParameters signupReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.registerURL,
        data: signupReq.toMap(),
      );
      return Right(response);
    }

    on DioException catch (e) {
      final message = e.response!.data['message'];
      return Left(message);
    }
  }
  
  @override
  Future<Either> getUser() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var response = await sl<DioClient>().get(
        'https://68850680745306380a3a226c.mockapi.io/api/v1/users',
        options: Options(
          headers: {
            'Authorization' : 'Bearer $token'
          }
        )
      );
      return Right(response);
    }
    on DioException catch (e) {
      final message = e.response!.data['message'];
      return Left(message);
    }
  }
  
  @override
  Future<Either> login(LoginRequestParameters loginReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.loginURL,
        data: loginReq.toMap(),
      );
      return Right(response);
    }
    on DioException catch (e) {
      final message = e.response!.data['message'];
      return Left(message);
    }
  }

  @override
  Future<Either> sendOtp(SendOtpRequestParameters otpReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.forgetPassURL,
        data: otpReq.toMap(),
      );
      return Right(response);
    } 
    on DioException catch (e) {
      final message = e.response!.data['message'];
      return Left(message);
    }
  }

  @override
  Future<Either> resetPassword(ResetPasswordRequestParameters param) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.resetPassURL,
        data: param.toMap(),
      );
      return Right(response);
    } 
    
    on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  Future<Either> verifyOtp(VerifyOtpRequest param) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.resetPassURL,
        data: param.toMap(),
      );
      return Right(response);
    } 
    
    on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

}