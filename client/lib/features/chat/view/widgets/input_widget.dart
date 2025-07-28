// lib/widgets/input_widget.dart
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSend;
  final VoidCallback onPickImage;

  const InputWidget({
    super.key,
    required this.textController,
    required this.onSend,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: textController,
              scrollPadding: const EdgeInsets.all(5),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Enter Your Message',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white, size: 30),
            onPressed: onSend,
          ),
          IconButton(
            icon: const Icon(Icons.photo, color: Colors.white, size: 30),
            onPressed: onPickImage,
          ),
        ],
      ),
    );
  }
}
