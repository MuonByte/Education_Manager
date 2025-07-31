import 'package:client/common/widgets/custom_header.dart';
import 'package:client/features/chat/view/pages/chat_page.dart';
import 'package:client/features/chat/viewmodel/bloc/chat_room/chat_room_state.dart';
import 'package:client/features/chat/viewmodel/bloc/messages/message_cubit.dart';
import 'package:client/features/chat/viewmodel/chat_room_viewmodel.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomsPage extends StatefulWidget {
  const ChatRoomsPage({super.key});

  @override
  State<ChatRoomsPage> createState() => _ChatRoomsPageState();
}

class _ChatRoomsPageState extends State<ChatRoomsPage> {
  final _roomNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatRoomViewModel>().getRooms();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(title: 'Chatroom'),
            Expanded(
              child: BlocBuilder<ChatRoomViewModel, ChatRoomState>(
                builder: (context, state) {
                  if (state is ChatRoomLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatRoomLoaded) {
                    if (state.rooms.isEmpty) {
                      return const Center(
                        child: Text(
                          "No chat rooms available.", 
                          style: TextStyle(fontFamily: 'Poppins'),
                        )
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.rooms.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final room = state.rooms[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider<MessagesCubit>(
                                  create: (_) => sl<MessagesCubit>(),
                                  child: ChatPage(room: room),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.shadowColor.withOpacity(0.12),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.chat_rounded, size: 28),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    room.roomName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: 'Poppins'
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<ChatRoomViewModel>().deleteRoom(room.roomId);
                                  },
                                  icon: Icon(Icons.delete_forever_rounded, color: theme.colorScheme.error),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ChatRoomError) {
                    return Center(child: Text("Error: ${state.error}", style: TextStyle(fontFamily: 'Poppins'),));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            _buildCreateRoomField(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateRoomField(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.12), 
            blurRadius: 8, 
            offset: const Offset(0, 2)
          )
        ],
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.refresh,
              color: theme.colorScheme.surfaceContainerHigh
            ),
            onPressed: () => context.read<ChatRoomViewModel>().getRooms(),
          ),
          Expanded(
            child: TextField(
              controller: _roomNameController,
              decoration: InputDecoration(
                hintText: 'Create new room...',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'Poppins', 
                  color: theme.colorScheme.surfaceContainerHigh
                )
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final name = _roomNameController.text.trim();
              if (name.isNotEmpty) {
                context.read<ChatRoomViewModel>().createRoom(name);
                _roomNameController.clear();
                await Future.delayed(const Duration(seconds: 1));
                context.read<ChatRoomViewModel>().getRooms();
              }
            },
            child: Icon(
              Icons.send_and_archive_rounded, 
              color: theme.colorScheme.surfaceContainerHigh
            ),
          ),
        ],
      ),
    );
  }
}
