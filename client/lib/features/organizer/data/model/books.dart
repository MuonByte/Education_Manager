import 'package:hive_ce/hive.dart';

part 'books.g.dart';

@HiveType(typeId: 0)
class Books extends HiveObject{
  Books(
    {
      required this.name,
      required this.subject,
      required this.status,
      this.feedback,
      this.pdfPath
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
  final String? pdfPath;
}