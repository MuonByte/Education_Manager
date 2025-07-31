import 'package:client/common/widgets/custom_header.dart';
import 'package:client/features/organizer/data/model/video.dart';
import 'package:client/features/organizer/view/widgets/custom_field.dart';
import 'package:client/features/organizer/viewmodel/video_tracker_viewmodel.dart';
import 'package:client/features/organizer/viewmodel/services/videos_service.dart';
import 'package:client/features/organizer/viewmodel/services/update_video_service.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoTrackerPage extends StatefulWidget {
  const VideoTrackerPage({super.key});

  @override
  State<VideoTrackerPage> createState() => _VideoTrackerPageState();
}

class _VideoTrackerPageState extends State<VideoTrackerPage> {
  final videoNameController = TextEditingController();
  final videoStatusController = TextEditingController();
  final videoSubjectController = TextEditingController();
  final videoLinkController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final VideoTrackerViewModel viewModel = VideoTrackerViewModel();

  @override
  void dispose() {
    videoNameController.dispose();
    videoStatusController.dispose();
    videoSubjectController.dispose();
    videoLinkController.dispose();
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
            CustomHeader(title: 'Video Organizer',),
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
                      hintText: 'Video Name',
                      controller: videoNameController,
                      customicon: Icons.movie_filter_outlined,
                    ),

                    SizedBox(height: spacing * 0.02),

                    CustomField(
                      hintText: 'Video Subject',
                      controller: videoSubjectController,
                      customicon: Icons.subject_outlined,
                    ),

                    SizedBox(height: spacing * 0.02),

                    CustomField(
                      hintText: 'Video Status',
                      controller: videoStatusController,
                      customicon: Icons.star_outline_sharp,
                    ),

                    SizedBox(height: spacing * 0.02),

                    CustomField(
                      hintText: 'Video Link (Optional)',
                      controller: videoLinkController,
                      customicon: Icons.link,
                    ),

                    SizedBox(height: spacing * 0.02),

                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add Video'),
                        onPressed: () {
                          setState(() {
                            viewModel.addVideo(
                              name: videoNameController.text,
                              subject: videoSubjectController.text,
                              status: videoStatusController.text,
                              videoLink: videoLinkController.text.trim().isEmpty ? null : videoLinkController.text.trim(),
                            );
                          });

                          videoNameController.clear();
                          videoStatusController.clear();
                          videoSubjectController.clear();
                          videoLinkController.clear();
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
              child: videosBox.isEmpty
                  ? Center(child: Text('No books added yet.', style: TextStyle(color: theme.colorScheme.surfaceContainerHigh, fontFamily: 'Poppins')))
                  : ListView.builder(
                      itemCount: videosBox.length,
                      itemBuilder: (context, index) {
                        final Video video = videosBox.getAt(index)!;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 3,
                          shadowColor: theme.colorScheme.secondary,
                          color: theme.colorScheme.surfaceContainerLow,
                          child: InkWell(
                            onLongPress: () {
                              showUpdateVideoDialog(
                                context: context,
                                index: index,
                                video: video,
                                viewModel: viewModel,
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
                                          video.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                      Chip(
                                        label: Text(
                                          video.status,
                                          style: TextStyle(color: theme.colorScheme.primaryContainer),
                                        ),
                                        backgroundColor: theme.colorScheme.surfaceContainerLow.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spacing * 0.01),
                                  Text(
                                    'Subject: ${video.subject}',
                                    style: TextStyle(
                                      color: theme.colorScheme.secondary,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(height: spacing * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (video.videoLink != null && video.videoLink!.isNotEmpty)
                                        TextButton.icon(
                                          icon: const Icon(Icons.link, color: Colors.blueAccent, size: 20),
                                          label: const Text("Open Link"),
                                          onPressed: () async {
                                            final url = Uri.parse(video.videoLink!);
                                            if (await canLaunchUrl(url)) {
                                              await launchUrl(url);
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Could not launch ${video.videoLink}')),
                                              );
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: theme.colorScheme.secondary,
                                          ),
                                        )
                                      else
                                        Text(
                                          "No link attached",
                                          style: TextStyle(color: theme.colorScheme.secondary),
                                        ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                            tooltip: "Edit",
                                            onPressed: () {
                                              showUpdateVideoDialog(
                                                context: context,
                                                index: index,
                                                video: video,
                                                viewModel: viewModel,
                                                onUpdated: () => setState(() {}),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.remove_circle_outline, color: theme.colorScheme.secondary),
                                            tooltip: "Delete",
                                            onPressed: () {
                                              setState(() {
                                                viewModel.deleteVideo(index);
                                              });
                                            },
                                          ),
                                        ],
                                      )
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
                    videosBox.clear();
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