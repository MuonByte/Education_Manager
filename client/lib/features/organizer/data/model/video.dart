import 'package:hive_ce/hive.dart';

part 'video.g.dart';

@HiveType(typeId: 3)
class Video extends HiveObject{
  Video(
    {
      required this.name,
      required this.subject,
      required this.status,
      this.feedback,
      this.videoLink
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

  @HiveField(4)
  final String? videoLink;
}