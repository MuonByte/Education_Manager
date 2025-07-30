import 'package:file_picker/file_picker.dart';

String? selectedPdfPath;

Future<void> pickPdf() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  if (result != null && result.files.single.path != null) {
    selectedPdfPath = result.files.single.path!;
  }
}


