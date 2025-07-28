// lib/pages/chat_page.dart
// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:io';
import 'package:eduscan_app/widgets/input_widget.dart';
import 'package:eduscan_app/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    super.key,
    required this.chatHistory,
    required this.roomId,
    required this.roomName,
  });
  Map chatHistory = {};
  String roomId;
  String roomName;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  File? file;
  List message = [];

  @override
  void initState() {
    super.initState();
    Gemini.init(apiKey: 'AIzaSyB3VtLG3BHwaw9MOCJw4o9G32ouJM533a8');
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    }
  }

  void addMessage() {
    if (textController.text.isEmpty) return;

    final userMessage = {
      'text': textController.text,
      'issender': true,
      'hasimage': file != null,
      'file': file,
    };

    setState(() => message.add(userMessage));
    scrollToBottom();

    final gemini = Gemini.instance;

    if (file != null) {
      gemini
          .textAndImage(
            text: textController.text,
            images: [file!.readAsBytesSync()],
          )
          .then((value) {
            setState(() {
              message.add({
                'text':
                    value?.content?.parts
                        ?.whereType<TextPart>()
                        .map((e) => e.text)
                        .join("\n") ??
                    "No response",
                'issender': false,
                'hasimage': false,
                'file': null,
              });
            });
            scrollToBottom();
          });
      file = null;
    } else {
      gemini.text(textController.text).then((value) {
        setState(() {
          message.add({
            'text': value?.output ?? "No response",
            'issender': false,
            'hasimage': false,
            'file': null,
          });
        });
        scrollToBottom();
      });
    }

    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Chat With AI',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: ListView.builder(
                controller: scrollController,
                itemCount: message.length,
                itemBuilder: (context, index) => MessageWidget(
                  text: message[index]['text'],
                  issender: message[index]['issender'],
                  hasimage: message[index]['hasimage'],
                  file: message[index]['file'],
                ),
              ),
            ),
          ),
          InputWidget(
            textController: textController,
            onSend: addMessage,
            onPickImage: getImage,
          ),
        ],
      ),
    );
  }
}
