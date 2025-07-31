import 'package:client/features/organizer/data/model/video.dart';
import 'package:client/features/organizer/viewmodel/video_tracker_viewmodel.dart';
import 'package:flutter/material.dart';

Future<void> showUpdateVideoDialog({
  required BuildContext context,
  required int index,
  required Video video,
  required VideoTrackerViewModel viewModel,
  required VoidCallback onUpdated,
}) async {
  String selectedStatus = ['To Watch', 'Watching', 'Watched'].contains(video.status)
      ? video.status
      : 'To Watch';

  final TextEditingController customStatusController = TextEditingController(
    text: !['To Watch', 'Watching', 'Watched'].contains(video.status) ? video.status : '',
  );

  final TextEditingController videoLinkController = TextEditingController(text: video.videoLink);

  await showDialog(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      final spacing = MediaQuery.of(context).size.height;

      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Update Video'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: ['To Watch', 'Watching', 'Watched'].contains(selectedStatus) ? selectedStatus : null,
                decoration: const InputDecoration(labelText: 'Select new status'),
                items: ['To Watch', 'Watching', 'Watched'].map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedStatus = value;
                    });
                  }
                },
              ),
              SizedBox(height: spacing * 0.01),
              TextField(
                controller: customStatusController,
                decoration: const InputDecoration(
                  labelText: 'Or enter custom status (optional)',
                ),
              ),
              SizedBox(height: spacing * 0.01),
              TextField(
                controller: videoLinkController,
                decoration: const InputDecoration(
                  labelText: 'Video Link (Optional)',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: theme.colorScheme.inversePrimary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final String finalStatus = customStatusController.text.trim().isNotEmpty
                    ? customStatusController.text.trim()
                    : selectedStatus;

                viewModel.updateVideo(
                  index: index,
                  newStatus: finalStatus,
                  newVideoLink: videoLinkController.text.trim().isEmpty ? null : videoLinkController.text.trim(),
                );
                onUpdated();
                Navigator.pop(context);
              },
              child: Text(
                'Update',
                style: TextStyle(
                  color: theme.colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}