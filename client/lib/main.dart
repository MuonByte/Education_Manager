<<<<<<< HEAD
import 'package:client/features/auth/views/pages/login_page.dart';
=======
>>>>>>> 662dd4f63f199a0b6a5ba308ae1a46240b1955be
import 'package:client/features/auth/views/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
        breakpoints: [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1920, name: DESKTOP),
            Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          child: child!,
        );
      },
      home: Scaffold(
        body: Center(
<<<<<<< HEAD
          child: LoginPage(),
=======
          child: Register(),
>>>>>>> 662dd4f63f199a0b6a5ba308ae1a46240b1955be
        ),
      ),
    );
  }
}
