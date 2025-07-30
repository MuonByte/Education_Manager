class VerifyOtpRequest {
  final String code;

  VerifyOtpRequest({
    required this.code, 
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
    };
  }
}
