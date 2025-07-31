import 'package:client/common/widgets/custom_header.dart';
import 'package:client/features/organizer/data/model/books.dart';
import 'package:client/features/organizer/data/model/project.dart';
import 'package:client/features/organizer/view/widgets/custom_field.dart';
import 'package:client/features/organizer/viewmodel/book_tracker_viewmodel.dart';
import 'package:client/features/organizer/viewmodel/project_tracker_viewmodel.dart';
import 'package:client/features/organizer/viewmodel/services/projects_service.dart';
import 'package:client/features/organizer/viewmodel/services/update_service.dart'; // Reusing update_service for projects

import 'package:flutter/material.dart';

class ProjectTrackerPage extends StatefulWidget {
  const ProjectTrackerPage({super.key});

  @override
  State<ProjectTrackerPage> createState() => _ProjectTrackerPageState();
}

class _ProjectTrackerPageState extends State<ProjectTrackerPage> {
  final projectNameController = TextEditingController();
  final projectStatusController = TextEditingController();
  final projectSubjectController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ProjectTrackerViewModel viewModel = ProjectTrackerViewModel();

  @override
  void dispose() {
    projectNameController.dispose();
    projectStatusController.dispose();
    projectSubjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: spacing*0.03,),
            CustomHeader(title: 'Project Organizer',),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(47, 0, 0, 0),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomField(
                      hintText: 'Project Name',
                      controller: projectNameController,
                      customicon: Icons.work_outline,
                    ),

                    SizedBox(height: spacing * 0.02),

                    CustomField(
                      hintText: 'Project Subject',
                      controller: projectSubjectController,
                      customicon: Icons.subject_outlined,
                    ),

                    SizedBox(height: spacing * 0.02),

                    CustomField(
                      hintText: 'Project Status',
                      controller: projectStatusController,
                      customicon: Icons.star_outline_sharp,
                    ),

                    SizedBox(height: spacing * 0.02),

                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add Project'),
                        onPressed: () {
                          setState(() {
                            viewModel.addProject(
                              name: projectNameController.text,
                              subject: projectSubjectController.text,
                              status: projectStatusController.text,
                            );
                          });

                          projectNameController.clear();
                          projectStatusController.clear();
                          projectSubjectController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.surfaceContainerLow,
                          foregroundColor: theme.colorScheme.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spacing* 0.01,),
            Expanded(
              child: projectsBox.isEmpty
                  ? Center(child: Text('No books added yet.', style: TextStyle(color: theme.colorScheme.surfaceContainerHigh, fontFamily: 'Poppins')))
                  : ListView.builder(
                      itemCount: projectsBox.length,
                      itemBuilder: (context, index) {
                        final Project project = projectsBox.getAt(index)!;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 3,
                          shadowColor: theme.colorScheme.secondary,
                          color: theme.colorScheme.surfaceContainerLow,
                          child: InkWell(
                            onLongPress: () {
                              showUpdateStatusDialog(
                                context: context,
                                index: index,
                                book: Books(name: project.name, subject: project.subject, status: project.status, feedback: project.feedback), // Pass a Books object for compatibility
                                viewModel: BookTrackerViewModel(),
                                onUpdated: () => setState(() {}),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          project.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                      Chip(
                                        label: Text(
                                          project.status,
                                          style: TextStyle(color: theme.colorScheme.primaryContainer),
                                        ),
                                        backgroundColor: theme.colorScheme.surfaceContainerLow.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spacing * 0.01),
                                  Text(
                                    'Subject: ${project.subject}',
                                    style: TextStyle(
                                      color: theme.colorScheme.secondary,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(height: spacing * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                        tooltip: "Edit",
                                        onPressed: () {
                                          showUpdateStatusDialog(
                                            context: context,
                                            index: index,
                                            book: Books(name: project.name, subject: project.subject, status: project.status, feedback: project.feedback), // Pass a Books object for compatibility
                                            viewModel: BookTrackerViewModel(),
                                            onUpdated: () => setState(() {}),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.remove_circle_outline, color: theme.colorScheme.secondary),
                                        tooltip: "Delete",
                                        onPressed: () {
                                          setState(() {
                                            viewModel.deleteProject(index);
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    projectsBox.clear();
                  });
                }, 
                label: Text(
                  'Delete All',
                  style: TextStyle(
                    color: theme.colorScheme.secondary
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}