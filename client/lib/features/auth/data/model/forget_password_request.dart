class ForgetPasswordRequestParameters {
  final String value;
  final String method;

  ForgetPasswordRequestParameters({
    required this.value,
    required this.method,
  });

  Map<String, dynamic> toMap() {
    return<String, dynamic>{
    'value' : value,
    'method' : method
    };
  }
}