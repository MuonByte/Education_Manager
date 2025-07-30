import 'package:client/common/widgets/custom_back_button.dart';
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<ChatRoomViewModel, ChatRoomState>(
                builder: (context, state) {
                  if (state is ChatRoomLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatRoomLoaded) {
                    if (state.rooms.isEmpty) {
                      return const Center(child: Text("No chat rooms available.", style: TextStyle(fontFamily: 'Poppins'),));
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
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
                                  icon: const Icon(Icons.delete_forever_rounded, color: Colors.red),
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
            _buildCreateRoomField(),
          ],
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
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          CustomBackButton(isAuth: true,),
          const SizedBox(width: 12),
          const Text(
            'Your Chat Rooms',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,fontFamily: 'Poppins'),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<ChatRoomViewModel>().getRooms(),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateRoomField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _roomNameController,
              decoration: const InputDecoration(
                hintText: 'Create new room...',
                border: InputBorder.none,
                hintStyle: TextStyle(fontFamily: 'Poppins')
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final name = _roomNameController.text.trim();
              if (name.isNotEmpty) {
                context.read<ChatRoomViewModel>().createRoom(name);
                _roomNameController.clear();
              }
            },
            child: const Icon(Icons.send_and_archive_rounded, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
