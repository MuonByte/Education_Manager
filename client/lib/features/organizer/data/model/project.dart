import 'package:hive_ce/hive.dart';

part 'project.g.dart';

@HiveType(typeId: 2)
class Project extends HiveObject{
  Project(
    {
      required this.name,
      required this.subject,
      required this.status,
      this.feedback,
    }
  );

  @HiveField(0)
  String name;

  @HiveField(1)
  String subject;

  @HiveField(2)
  String status;

  @HiveField(3)
  String? feedback;
}