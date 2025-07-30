import 'package:client/common/widgets/custom_appbar.dart';
import 'package:client/features/organizer/data/model/books.dart';
import 'package:client/features/organizer/view/widgets/custom_field.dart';
import 'package:client/features/organizer/viewmodel/book_tracker_viewmodel.dart';
import 'package:client/features/organizer/viewmodel/services/books_service.dart';
import 'package:client/features/organizer/viewmodel/services/pdf_service.dart';
import 'package:client/features/organizer/viewmodel/services/update_service.dart';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';


class BookTrackerPage extends StatefulWidget {
  const BookTrackerPage({super.key});

  @override
  State<BookTrackerPage> createState() => _BookTrackerPageState();
}

class _BookTrackerPageState extends State<BookTrackerPage> {
  final bookNameController = TextEditingController();
  final bookSatController = TextEditingController();
  final bookSubjectController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final BookTrackerViewModel viewModel = BookTrackerViewModel();

  @override
  void dispose() {
    bookNameController.dispose();
    bookSatController.dispose();
    bookSubjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomField(
                      hintText: 'Book Name',
                      controller: bookNameController,
                      customicon: Icons.abc_outlined,
                    ),

                    SizedBox(height: spacing * 0.02),

                    CustomField(
                      hintText: 'Book Subject',
                      controller: bookSubjectController,
                      customicon: Icons.subject_outlined,
                    ),

                    SizedBox(height: spacing * 0.02),

                    CustomField(
                      hintText: 'Book Status',
                      controller: bookSatController,
                      customicon: Icons.star_outline_sharp,
                    ),

                    SizedBox(height: spacing * 0.02),

                    ElevatedButton(
                      onPressed: () async {
                        await pickPdf();
                      },
                      child: Text(selectedPdfPath == null ? 'Attach PDF (Optional)' : 'PDF Attached',
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(theme.colorScheme.surfaceContainerHighest)
                      ),
                    ),

                    SizedBox(height: spacing * 0.02),

                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add Book'),
                        onPressed: () {
                          setState(() {
                            viewModel.addBook(
                              name: bookNameController.text,
                              subject: bookSubjectController.text,
                              status: bookSatController.text,
                            );
                          });

                          bookNameController.clear();
                          bookSatController.clear();
                          bookSubjectController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
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


            SizedBox(height: spacing * 0.03),

            Expanded(
              child: booksBox.isEmpty
                  ? Center(child: Text('No books added yet.', style: theme.textTheme.bodyMedium))
                  : ListView.builder(
                      itemCount: booksBox.length,
                      itemBuilder: (context, index) {
                        final Books book = booksBox.getAt(index)!;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 3,
                          shadowColor: theme.colorScheme.secondary,
                          color: theme.colorScheme.primaryFixedDim,
                          child: InkWell(
                            onLongPress: () {
                              showUpdateStatusDialog(
                                context: context,
                                index: index,
                                book: book,
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
                                          book.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                      Chip(
                                        label: Text(
                                          book.status,
                                          style: TextStyle(color: theme.colorScheme.onPrimary),
                                        ),
                                        backgroundColor: theme.colorScheme.secondary.withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spacing * 0.01),
                                  Text(
                                    'Subject: ${book.subject}',
                                    style: TextStyle(
                                      color: theme.colorScheme.secondary,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(height: spacing * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (book.pdfPath != null)
                                        TextButton.icon(
                                          icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 20),
                                          label: const Text("Open PDF"),
                                          onPressed: () => OpenFile.open(book.pdfPath),
                                          style: TextButton.styleFrom(
                                            foregroundColor: theme.colorScheme.secondary,
                                          ),
                                        )
                                      else
                                        Text(
                                          "No PDF attached",
                                          style: TextStyle(color: theme.colorScheme.secondary),
                                        ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                            tooltip: "Edit",
                                            onPressed: () {
                                              showUpdateStatusDialog(
                                                context: context,
                                                index: index,
                                                book: book,
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
                                                viewModel.deleteBook(index);
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
                    booksBox.clear();
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
