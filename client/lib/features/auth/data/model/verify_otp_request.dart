class VerifyOtpRequest {
  final String value;
  final String method; 
  final String otp;

  VerifyOtpRequest({
    required this.value,
    required this.method,
    required this.otp,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'method': method,
      'otp': otp,
    };
  }
}
