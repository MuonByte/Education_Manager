import 'package:client/features/chat/data/model/chat_parameters.dart';
import 'package:client/features/chat/view/pages/chat_page.dart';
import 'package:client/features/chat/view/pages/chat_room_display.dart';
import 'package:client/features/auth/views/pages/register_page.dart';
import 'package:client/features/home/view/pages/home_page.dart';

import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());

      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/chat-rooms':
        return MaterialPageRoute(builder: (_) => const ChatRoomsPage());

      case '/chat-page':
        final args = settings.arguments;
        if (args is ChatRoomModel) {
          return MaterialPageRoute(
            builder: (_) => ChatPage(room: args),
          );
        }
        return _errorRoute("Invalid arguments for /chat-page");

      default:
        return _errorRoute("Route not found");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text(message)),
      ),
    );
  }
}
