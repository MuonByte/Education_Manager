import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomDrawer extends StatefulWidget {
  const ChatRoomDrawer({super.key});

  @override
  State<ChatRoomDrawer> createState() => _ChatRoomDrawer();
}

class _ChatRoomDrawer extends State<ChatRoomDrawer> {
  final List<Map<String, String>> chatRooms = [
    {'id': '1', 'name': 'Flutter Room'},
    {'id': '2', 'name': 'AI Room'},
    {'id': '3', 'name': 'Study Group'},
  ];

  final Map<String, List<Map<String, dynamic>>> chatHistory = {};

  void openChatRoomsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return ListView.builder(
          itemCount: chatRooms.length,
          itemBuilder: (context, index) {
            final room = chatRooms[index];
            return ListTile(
              title: Text(
                room['name']!,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      roomId: room['id']!,
                      roomName: room['name']!,
                      chatHistory: chatHistory,
                    ),
                  ),
                ).then((_) => setState(() {}));
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit_calendar_sharp),
              iconSize: 30.sp,
              onPressed: openChatRoomsMenu,
            ),
            Center(
              child: Text('Add Chat Room', style: TextStyle(fontSize: 20.sp)),
            ),
          ],
        ),

        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Welcome to the App!', style: TextStyle(fontSize: 20.sp)),
      ),
    );
  }
}
