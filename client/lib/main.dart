import 'package:client/features/auth/viewmodel/bloc/auth/auth_state.dart';
import 'package:client/features/auth/viewmodel/bloc/auth/auth_state_cubit.dart';
import 'package:client/features/auth/views/pages/register_page.dart';
import 'package:client/features/profile/views/pages/profile_page.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  setupServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthStateCubit()..started(),
      child: MaterialApp(
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
        home: BlocBuilder<AuthStateCubit,AuthState>(
          builder: (context, state) {
            if(state is Authenticated) {
              return ProfilePage();
            }
            if(state is Unauthenticated) {
              return Register();
            }
            return Placeholder();
          },
        )
      ),
    );
  }
}
