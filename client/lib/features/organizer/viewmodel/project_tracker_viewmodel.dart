import 'package:client/features/organizer/data/model/project.dart';
import 'package:client/features/organizer/viewmodel/services/projects_service.dart';

class ProjectTrackerViewModel {
  void addProject({
    required String name,
    required String subject,
    required String status,
  }) {
    if (name.trim().isEmpty || subject.trim().isEmpty || status.trim().isEmpty) return;

    projectsBox.put(
      'ProjectKey_$name',
      Project(
        name: name,
        subject: subject,
        status: status,
      ),
    );
  }

  void deleteProject(int index) {
    projectsBox.deleteAt(index);
  }

  void updateProjectStatus(int index, String newStatus) {
    final Project? project = projectsBox.getAt(index);

    if (project != null) {
      final updatedProject = Project(
        name: project.name,
        subject: project.subject,
        status: newStatus,
      );

      projectsBox.putAt(index, updatedProject);
    }
  }

  void updateProject({
    required int index,
    required String newStatus,
  }) {
    final oldProject = projectsBox.getAt(index);
    if (oldProject == null) return;

    final updatedProject = Project(
      name: oldProject.name,
      subject: oldProject.subject,
      status: newStatus,
      feedback: oldProject.feedback,
    );

    projectsBox.putAt(index, updatedProject);
  }
}