
class SignupRequestParameters {
  
  final String email;
  final String password;
  final String username;

  SignupRequestParameters({
    required this.email, 
    required this.password, 
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return<String, dynamic>{
      'email' : email,
      'password' : password,
      'name' : username,
    };
  }
}