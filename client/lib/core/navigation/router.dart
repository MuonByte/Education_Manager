import 'package:flutter/material.dart';
import 'package:client/features/auth/views/pages/register_page.dart';
import 'package:client/features/home/view/pages/home_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}