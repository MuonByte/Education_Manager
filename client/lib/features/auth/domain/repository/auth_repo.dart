import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/data/model/register_request.dart';

import 'package:dartz/dartz.dart';

abstract class AuthRepository {

  Future<Either> signup(SignupRequestParameters signupReq);
  Future<Either> login(LoginRequestParameters loginReq);
  Future<bool> isAuth(); 
  Future<Either> getUser();
  Future logout();
}