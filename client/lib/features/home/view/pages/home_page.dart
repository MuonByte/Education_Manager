import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/common/widgets/custom_button.dart';
import 'package:client/common/widgets/custom_navbar.dart';
import 'package:client/common/widgets/custom_back_button.dart';
import 'package:client/common/widgets/theme_toggle_button.dart';
import 'package:client/features/chat/view/pages/chat_room_display.dart';
import 'package:client/features/organizer/view/pages/book_tracker_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoomsPage()));
    }
    if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookTrackerPage()));
    } 
    else {
      setState(() => _currentIndex = index);
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final iconWidth = ResponsiveValue<double>(
      context,
      defaultValue: screenWidth * 0.4,
      conditionalValues: [
        Condition.smallerThan(name: MOBILE, value: screenWidth * 0.3),
        Condition.largerThan(name: TABLET, value: screenWidth * 0.2),
      ],
    ).value;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      body: BlocProvider(
        create: (_) => ButtonStateCubit(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CustomBackButton(isAuth: true),
                      Spacer(),
                      ThemeToggleButton(),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.07),

                  Image.asset(
                    'assets/icon/app_icon.png',
                    width: iconWidth,
                    fit: BoxFit.contain,
                    color: theme.colorScheme.surfaceContainerHigh,
                  ),

                  SizedBox(height: screenHeight * 0.07),

                  Text(
                    'Welcome to\nYour Education\nManager',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      color: theme.colorScheme.surfaceContainerHigh,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  Text(
                    'Start chatting with TutorAI now.\nYou can ask me anything.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: theme.colorScheme.surfaceContainerHigh,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.1),

                  _getStarted(context, theme),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _getStarted(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomButton(
        buttonText: 'Get Started',
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ChatRoomsPage()),
          );
        },
        backgroundColor: theme.colorScheme.surfaceContainerHigh,
      ),
    );
  }

}
