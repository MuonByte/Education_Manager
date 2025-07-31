class UserEntity {
  final String userId;
  final String email;
  final String username;
  final bool isVerified;

  UserEntity({
    required this.email, 
    required this.username,
    required this.userId,
    this.isVerified = false,
  });
}