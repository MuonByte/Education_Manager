

import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<bool> isAuth(); 
  Future logout();
} 

class AuthLocalServiceImplementation extends AuthLocalService {
  @override
  Future<bool> isAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    if(token == null){
      return false;
    }
    else {
      return true;
    }
  }
  
  @override
  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
  
}