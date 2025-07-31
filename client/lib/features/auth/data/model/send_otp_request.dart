class SendOtpRequestParameters {
  final String value;
  final String? method;

  SendOtpRequestParameters({
    required this.value,
    this.method,
  });

  Map<String, dynamic> toMap() {
    return<String, dynamic>{
    'value' : value,
    'method' : method
    };
  }
}