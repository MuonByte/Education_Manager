import 'package:client/features/auth/data/model/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {

  Future<Either> signup(SignupRequestParameters signupReq);
  Future<bool> isAuth(); 
  Future<Either> getUser();
  Future logout();
}