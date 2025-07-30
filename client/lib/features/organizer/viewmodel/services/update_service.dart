import 'package:client/features/organizer/data/model/books.dart';
import 'package:client/features/organizer/viewmodel/book_tracker_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


Future<void> showUpdateStatusDialog({
  required BuildContext context,
  required int index,
  required Books book,
  required BookTrackerViewModel viewModel,
  required VoidCallback onUpdated,
}) async {
  String selectedStatus = ['To Read', 'Reading', 'Done'].contains(book.status)
      ? book.status
      : 'To Read';

  final TextEditingController customStatusController = TextEditingController(
    text: !['To Read', 'Reading', 'Done'].contains(book.status) ? book.status : '',
  );

  String? selectedPdfPath = book.pdfPath;

  await showDialog(
    context: context,
    builder: (context) {

      final theme = Theme.of(context);
      final spacing = MediaQuery.of(context).size.height;

      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Update Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: ['To Read', 'Reading', 'Done'].contains(selectedStatus) ? selectedStatus : null,
                decoration: const InputDecoration(labelText: 'Select new status'),
                items: ['To Read', 'Reading', 'Done'].map((status) {
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
              ElevatedButton.icon(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );
                  if (result != null && result.files.single.path != null) {
                    setState(() => selectedPdfPath = result.files.single.path!);
                  }
                },
                icon: Icon(
                  Icons.attach_file,
                  color: theme.colorScheme.inversePrimary,
                ),
                label: Text(selectedPdfPath != null ? 'PDF Attached' : 'Attach PDF (Optional)',
                  style: TextStyle(
                    color: theme.colorScheme.inversePrimary,
                  ),
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

                viewModel.updateBook(
                  index: index,
                  newStatus: finalStatus,
                  newPdfPath: selectedPdfPath,
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
