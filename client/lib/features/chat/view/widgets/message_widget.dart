import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final bool issender;
  final bool hasimage;
  final File? file;

  const MessageWidget({
    super.key,
    required this.text,
    required this.issender,
    required this.hasimage,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: issender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: issender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (hasimage && file != null)
            Container(
              height: 200,
              width: 300,
              margin: const EdgeInsets.only(bottom: 0.5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(file!),
                  fit: BoxFit.cover,
                ),
                color: Colors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: issender ? Colors.black : Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              style: TextStyle(color: issender ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
