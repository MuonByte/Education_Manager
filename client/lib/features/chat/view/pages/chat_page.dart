import 'package:client/features/auth/viewmodel/bloc/auth/auth_state.dart';
import 'package:client/features/auth/viewmodel/bloc/auth/auth_state_cubit.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/common/widgets/custom_back_button.dart';
import 'package:client/features/chat/viewmodel/bloc/messages/message_cubit.dart';
import 'package:client/features/chat/viewmodel/bloc/messages/message_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final ChatRoomModel room;
  const ChatPage({super.key, required this.room});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<MessagesCubit>().fetchMessages(
      FetchMessagesParams(roomId: widget.room.roomId),
    );
  });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final authState = context.read<AuthStateCubit>().state;
    if (authState is Authenticated) {
      final userId = authState.user.userId;

      context.read<MessagesCubit>().sendMessage(
        SendMessageParams(
          roomId: widget.room.roomId,
          messageText: text,
          userId: userId!,
        ),
      );

      _controller.clear();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildChatSection()),
              _buildInputField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          const CustomBackButton(),
          const SizedBox(width: 12),
          Text(
            widget.room.roomName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.photo),
                          title: const Text('Send Photo'),
                          onTap: () {
                            Navigator.pop(context);
                            //_pickImageFromGallery();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Take Photo'),
                          onTap: () {
                            Navigator.pop(context);
                            //_openCamera();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.more_horiz, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildChatSection() {
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {
        if (state is MessagesLoaded) _scrollToBottom();
      },
      builder: (context, state) {
        final authState = context.read<AuthStateCubit>().state;
        final currentUserId = authState is Authenticated ? authState.user.userId : null;
        if (state is MessagesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MessagesLoaded) {
          final messages = state.messages;
          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: messages.length,
            itemBuilder: (context, i) {
              final msg = messages[i];
              final isUser = msg.userId == currentUserId;

              return isUser
                ? _UserSection(text: msg.messageText)
                : _AISection(text: msg.messageText);
            }
          );
        } else if (state is MessagesError) {
          return Center(child: Text(state.error));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildInputField() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Send a message.',
                border: InputBorder.none,
                hintStyle: TextStyle(fontFamily: 'Poppins'),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          GestureDetector(
            onTap: _sendMessage,
            child: const Icon(Icons.send, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _UserSection extends StatelessWidget {
  final String text;
  const _UserSection({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_2_rounded, size: 30),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
          const Icon(Icons.edit, size: 20, color: Colors.grey),
        ],
      ),
    );
  }
}

class _AISection extends StatelessWidget {
  final String text;
  const _AISection({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/icon/app_icon.png', width: 55),
              const SizedBox(width: 8),
              const Spacer(),
              const Icon(Icons.copy, size: 20),
              const SizedBox(width: 12),
              const Icon(Icons.share, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }
  
}


