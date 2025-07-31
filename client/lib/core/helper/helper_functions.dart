String maskPhoneNumber(String fullNumber) {
  final digits = fullNumber.replaceAll(RegExp(r'[^0-9]'), '');

  if (digits.length <= 4) return fullNumber;

  final maskedPart = '•' * (digits.length - 4);
  final lastFour = digits.substring(digits.length - 4);

  return '+${digits.substring(0, 2)} $maskedPart$lastFour';
}

String maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length != 2) return email;

  final username = parts[0];
  final domain = parts[1];

  String maskedUsername;
  if (username.length <= 2) {
    maskedUsername = username[0] + '•';
  } else {
    maskedUsername = username[0] + '•' * (username.length - 2) + username[username.length - 1];
  }

  return '$maskedUsername@$domain';
}

bool getIsVerified(Map<String, dynamic> data) {
  final isVerifiedValue = data['isVerified'];
  if (isVerifiedValue is int) {
    return isVerifiedValue == 1;
  } else if (isVerifiedValue is bool) {
    return isVerifiedValue;
  }
  return false; 
}