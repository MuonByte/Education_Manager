import 'dart:io';
import 'package:flutter/material.dart';

class ImageDisplayPage extends StatelessWidget {
  final String imagePath;

  const ImageDisplayPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.file(File(imagePath))],
      ),
    );
  }
}
