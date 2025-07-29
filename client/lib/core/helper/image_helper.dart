import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

Future<void> _pickImageFromGallery() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    print('Picked from gallery: ${image.path}');
    // upload/send the image
  }
}

Future<void> _openCamera() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    print('Captured with camera: ${image.path}');
    // upload/send the image
  }
}