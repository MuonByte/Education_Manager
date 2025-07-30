class ResetPasswordRequestParameters {
  final String value;
  final String code;

  ResetPasswordRequestParameters({
    required this.value,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'code': code,
    };
  }
}
