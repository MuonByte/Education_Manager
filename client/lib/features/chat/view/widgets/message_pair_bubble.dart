import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/view/pages/chat_page.dart';
import 'package:client/features/chat/view/widgets/ai_section.dart';
import 'package:client/features/chat/view/widgets/user_section.dart';
import 'package:flutter/material.dart';


class MessagePairBubble extends StatefulWidget {
  final UserMessageData? userMessage;
  final AIMessageData? aiMessage;

  const MessagePairBubble({
    Key? key,
    this.userMessage,
    this.aiMessage,
  }) : super(key: key);

  @override
  State<MessagePairBubble> createState() => _MessagePairBubbleState();
}
class _MessagePairBubbleState extends State<MessagePairBubble> {
  bool showAI = false;

  @override
  void initState() {
    super.initState();
    if (widget.aiMessage != null) {
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) {
          setState(() {
            showAI = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.userMessage != null)
          UserSection(text: widget.userMessage!.content),
        if (showAI && widget.aiMessage != null)
          AISection(text: widget.aiMessage!.content),
      ],
    );
  }
}