import 'package:client/core/constants/api_urls.dart';
import 'package:client/features/auth/data/model/forget_password_request.dart';
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
  Future<Either> forgetPassword(ForgetPasswordRequestParameters forgetReq);
  Future<Either> resetPassword(ResetPasswordRequestParameters param);
  Future<Either> verifyOtp(VerifyOtpRequest param);
} 

class AuthApiServiceImplementation extends AuthApiService {
  @override
  Future<Either> signup(SignupRequestParameters signupReq) async {
    try {
      var response = await sl<DioClient>().post(
        'https://webhook.site/4e8cb70b-7535-4ff5-9d5e-9a89f1afa4df',
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
        'https://webhook.site/4e8cb70b-7535-4ff5-9d5e-9a89f1afa4df',
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
        'https://webhook.site/4e8cb70b-7535-4ff5-9d5e-9a89f1afa4df',
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
  Future<Either> forgetPassword(ForgetPasswordRequestParameters forgetReq) async {
    try {
      var response = await sl<DioClient>().post(
        'https://webhook.site/4e8cb70b-7535-4ff5-9d5e-9a89f1afa4df',
        data: forgetReq.toMap(),
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
        'https://webhook.site/4e8cb70b-7535-4ff5-9d5e-9a89f1afa4df',
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
        'https://webhook.site/4e8cb70b-7535-4ff5-9d5e-9a89f1afa4df',
        data: param.toMap(),
      );
      return Right(response);
    } 
    
    on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

}