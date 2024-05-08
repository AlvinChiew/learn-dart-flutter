import 'dart:io';

import 'package:app/scripts/take_photo.dart';
import 'package:flutter/material.dart';

class PhotoInput extends StatefulWidget {
  const PhotoInput(this.returnPhoto, {super.key});
  final void Function(File photo) returnPhoto;

  @override
  State<PhotoInput> createState() => _PhotoInputState();
}

class _PhotoInputState extends State<PhotoInput> {
  File? picture;

  void takePicture() async {
    final newPicture = await takePhoto();
    setState(() {
      picture = newPicture;
    });

    widget.returnPhoto(newPicture!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: picture == null
          ? TextButton.icon(
              onPressed: takePicture,
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture'),
            )
          : GestureDetector(
              onTap: takePicture,
              child: Image.file(
                picture!,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
    );
  }
}
