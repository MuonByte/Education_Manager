import 'package:client/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String? userId;
  final String? email;
  final String? username;

  UserModel({
    required this.email, 
    required this.username, 
    required this.userId
  });

  factory UserModel.fromMap(Map<String,dynamic> map) {
    return UserModel(
      userId : map['userId'], 
      email: map['email'], 
      username: map['username']
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    if (userId == null || email == null || username == null) {
      throw Exception("Invalid user data: some fields are null");
    }

    return UserEntity(
      userId: userId ?? '',
      email: email ?? '',
      username: username ?? '',
    );
  }
}
