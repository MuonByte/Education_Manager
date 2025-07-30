import 'package:client/features/auth/data/model/send_otp_request.dart';
import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/data/model/register_request.dart';
import 'package:client/features/auth/data/model/reset_password_requset.dart';
import 'package:client/features/auth/data/model/user_model.dart';
import 'package:client/features/auth/data/model/verify_otp_request.dart';
import 'package:client/features/auth/data/source/auth_api_service.dart';
import 'package:client/features/auth/data/source/auth_local_service.dart';
import 'package:client/features/auth/domain/entities/user_entity.dart';
import 'package:client/features/auth/domain/repository/auth_repo.dart';
import 'package:client/services/service_locator.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImplementation extends AuthRepository{

  @override
  Future<Either> signup(SignupRequestParameters signupReq) async {
    Either result = await sl<AuthApiService>().signup(signupReq);
    return result.fold(
      (error) => Left(error),
      (data) async {
        Response response = data;
        return Right(response);
      },
    );
  }
  
  @override
  Future<bool> isAuth() async {
    return await sl<AuthLocalService>().isAuth();
  }
  
  @override
  Future<Either<String, UserEntity>> getUser() async {
    Either result = await sl<AuthApiService>().getUser();

    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        Response response = data;
        final responseData = response.data;
        Map<String, dynamic> userMap;

        if (responseData is List && responseData.isNotEmpty) {
          userMap = responseData.first as Map<String, dynamic>;
        } else if (responseData is Map<String, dynamic>) {
          userMap = responseData;
        } else {
          return Left('Unexpected user data format');
        }

        try {
          final userModel = UserModel.fromMap(userMap);
          final userEntity = userModel.toEntity();
          return Right(userEntity);
        } catch (e) {
          return Left('Failed to parse user: ${e.toString()}');
        }
      },
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
      (error) => Left(error),
      (data) async {
        Response response = data;
        return Right(response);
      },
    );
  }
  
  @override
  Future<Either> sendOtp(SendOtpRequestParameters otpReq) async {
    final result = await sl<AuthApiService>().sendOtp(otpReq);
    return result.fold(
      (error) => Left(error),
      (data) => Right(data),
    );
  }

  @override
  Future<Either> resetPassword(ResetPasswordRequestParameters param) async {
    final result = await sl<AuthApiService>().resetPassword(param);
    return result.fold(
      (error) => Left(error),
      (data) => Right(data),
    );
  }

  @override
  Future<Either> verifyOtp(VerifyOtpRequest param) async {
    final result = await sl<AuthApiService>().verifyOtp(param);
    return result.fold(
      (error) => Left(error),
      (data) => Right(data),
    );
  }
}
