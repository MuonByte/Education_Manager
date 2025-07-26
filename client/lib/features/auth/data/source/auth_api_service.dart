import 'package:client/core/constants/api_urls.dart';
import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/data/model/register_request.dart';
import 'package:client/services/service_locator.dart';

import 'package:client/core/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthApiService {

Future<Either> signup(SignupRequestParameters signupReq);
Future<Either> getUser();
Future<Either> login(LoginRequestParameters loginReq);
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
        ApiUrls.userProfileURL,
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

  
}