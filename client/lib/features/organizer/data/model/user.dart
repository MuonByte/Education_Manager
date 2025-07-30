import 'package:hive_ce/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(3)
  final String password;

  User(
      this.name,
      this.email,
      this.password,
  );
}