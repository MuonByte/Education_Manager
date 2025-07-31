import 'package:client/features/organizer/data/model/project.dart';

import 'package:hive_ce/hive.dart';

late Box<Project> projectsBox;

class ProjectsService {
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ProjectAdapter());
    }
    projectsBox = await Hive.openBox<Project>('projectsData');
  }
}