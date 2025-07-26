class ResetPasswordRequestParameters {
  final String value;
  final String method; 
  final String otp;
  final String newPassword;

  ResetPasswordRequestParameters({
    required this.value,
    required this.method,
    required this.otp,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'method': method,
      'otp': otp,
      'new_password': newPassword,
    };
  }
}
