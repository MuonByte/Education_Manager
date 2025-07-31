import 'package:client/features/auth/data/source/auth_local_service.dart';
import 'package:client/features/auth/viewmodel/bloc/auth/auth_state.dart';
import 'package:client/features/auth/viewmodel/bloc/auth/auth_state_cubit.dart';
import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/common/widgets/custom_back_button.dart';
import 'package:client/features/chat/view/widgets/message_pair_bubble.dart';
import 'package:client/features/chat/viewmodel/bloc/messages/message_cubit.dart';
import 'package:client/features/chat/viewmodel/bloc/messages/message_state.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  
  void _sendMessage() {
  final text = _controller.text.trim();
  if (text.isEmpty) return;

  String? userId = sl<AuthLocalService>().getUserIdSync();;
  //final authState = context.read<AuthStateCubit>().state;

  context.read<MessagesCubit>().sendMessage(
    SendMessageParams(
      roomId: widget.room.roomId,
      content: text,
      userId: userId.toString(),
    ),
  );

  _controller.clear();
}


/*   void _sendImageMessage(File imageFile) {
    final authState = context.read<AuthStateCubit>().state;
    final currentUserId = sl<AuthLocalService>().getUserIdSync();
    print('$currentUserId');
    if (authState is Authenticated) {
      final userId = authState.user.userId;
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not authenticated. Cannot send image.')),
        );
        return;
      }
      context.read<MessagesCubit>().sendMessage(
        SendMessageParams(
          roomId: widget.room.roomId,
          imageFile: imageFile,
          userId: userId,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to send images.')),
      );
    }
  } */


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
/*                         ListTile(
                          leading: const Icon(Icons.photo),
                          title: const Text('Send Photo'),
                          onTap: () async {
                            final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              _sendImageMessage(File(pickedFile.path));
                            }
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Take Photo'),
                          onTap: () async {
                            final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                            if (pickedFile != null) {
                              _sendImageMessage(File(pickedFile.path));
                            }
                            Navigator.pop(context);
                          },
                        ), */
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
      if (state is MessagesLoaded) {
        _scrollToBottom();
      }
    },
    builder: (context, state) {
      if (state is MessagesLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is MessagesLoaded) {
        final messages = state.messages;

        if (messages.isEmpty) {
          return const Center(child: Text("No messages yet. Say hi!"));
        }

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: messages.length,
          itemBuilder: (context, i) {
            final msg = messages[i];
            return MessagePairBubble(
              userMessage: msg.userMessage,
              aiMessage: msg.aIMessage,
            );
          },
        );
      }

      if (state is MessagesError) {
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
              onTap: () => _sendMessage(),
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

