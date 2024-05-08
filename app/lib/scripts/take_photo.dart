import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> takePhoto() async {
  final imagePicker = ImagePicker();
  final pickedImage =
      await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
  if (pickedImage == null) {
    return null;
  }
  return File(pickedImage.path);
}
