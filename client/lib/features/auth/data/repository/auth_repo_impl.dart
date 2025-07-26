import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/data/model/register_request.dart';
import 'package:client/features/auth/data/model/user_model.dart';
import 'package:client/features/auth/data/source/auth_api_service.dart';
import 'package:client/features/auth/data/source/auth_local_service.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImplementation extends AuthRepository{

  @override
  Future<Either> signup(SignupRequestParameters signupReq) async {
    Either result = await sl<AuthApiService>().signup(signupReq);
    return result.fold(
      (error) {
        return Left(error);
      }, 
      (data) async {
        Response response = data;
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', response.data['token']);
        return Right(response);
      }
    );
  }
  
  @override
  Future<bool> isAuth() async {
    return await sl<AuthLocalService>().isAuth();
  }
  
  @override
  Future<Either> getUser() async {
    Either result = await sl<AuthApiService>().getUser();
    return result.fold(
      (error) {
        return Left(error);
      }, 
      (data) {
        Response response = data;
        var userModel = UserModel.fromMap(response.data);
        var userEntity = userModel.toEntity();
        return Right(userEntity);
      }
    );
  }
  
  @override
  Future logout() async {
    await sl<AuthLocalService>().logout();
  }

  @override
  Future<Either> login(LoginRequestParameters loginReq) async {
    Either result = await sl<AuthApiService>().login(loginReq);
    return result.fold(
      (error) {
        return Left(error);
      }, 
      (data) async {
        Response response = data;
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', response.data['token']);
        return Right(response);
      }
    );
  }

}