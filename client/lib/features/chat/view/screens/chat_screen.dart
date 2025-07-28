// ignore_for_file: unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:file_picker/file_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController scrollControlle = ScrollController();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollControlle.hasClients) {
        scrollControlle.animateTo(
          0.0, // لأن ListView.reverse = true
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendTextMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'type': 'text',
        'text': text.trim(),
        'isSender': true,
        'date': DateTime.now(),
      });
    });
    scrollToBottom();
    _controller.clear();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _messages.add({
          'type': 'image',
          'path': picked.path,
          'isSender': true,
          'date': DateTime.now(),
        });
      });
    }
  }

  Widget _buildBubble(Map<String, dynamic> msg) {
    final bool isSender = msg['isSender'] ?? false;

    switch (msg['type']) {
      case 'text':
        return BubbleNormal(
          text: msg['text'],
          isSender: isSender,
          color: isSender ? const Color(0xFFE8E8EE) : const Color(0xFF1B97F3),
          tail: true,
          textStyle: TextStyle(
            fontSize: 16.sp,
            color: isSender ? Colors.black : Colors.white,
          ),
        );

      case 'image':
        return BubbleNormalImage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          image: Image.file(File(msg['path']), fit: BoxFit.cover),
          isSender: isSender,
          color: isSender ? const Color(0xFFE8E8EE) : const Color(0xFF1B97F3),
          tail: true,
        );

      default:
        return const SizedBox();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollControlle,
              padding: const EdgeInsets.only(bottom: 16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: _buildBubble(_messages[index]),
                );
              },
            ),
          ),
          MessageBar(
            onSend: _sendTextMessage,
            actions: [
              InkWell(
                onTap: _pickImage,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.image, color: Colors.green, size: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
