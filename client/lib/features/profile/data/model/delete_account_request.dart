class DeleteAccountRequestParameters {
  final String password;

  DeleteAccountRequestParameters({
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
    };
  }
}
