import 'package:client/core/navigation/router.dart';
import 'package:client/core/network/dio_client.dart';
import 'package:client/features/auth/data/source/auth_local_service.dart';
import 'package:client/features/auth/viewmodel/bloc/auth/auth_state.dart';
import 'package:client/features/auth/viewmodel/bloc/auth/auth_state_cubit.dart';
import 'package:client/features/auth/views/pages/login_page.dart';
import 'package:client/features/chat/viewmodel/chat_room_viewmodel.dart';
import 'package:client/features/auth/views/pages/register_page.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:client/features/organizer/viewmodel/services/books_service.dart';
import 'package:client/features/organizer/viewmodel/services/projects_service.dart';
import 'package:client/features/organizer/viewmodel/services/videos_service.dart';
import 'package:client/features/profile/views/pages/profile_page.dart';
import 'package:client/features/theme/model/storage_service.dart';
import 'package:client/features/theme/viewmodel/theme_bloc.dart';
import 'package:client/features/theme/viewmodel/theme_state.dart';
import 'package:client/services/service_locator.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = await DioClient.create(
    baseUrl: 'http://192.168.1.15:3000',
  );

  sl.registerSingleton<DioClient>(dioClient);

  await setupServiceLocator();

  final storageService = StorageService();
  final bookService = BooksService();
  final projectsService = ProjectsService();
  final videosService = VideosService();
  final authService = sl<AuthLocalService>();
  final isAuthenticated = await authService.isAuth();

  try {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }
    if (authService is AuthLocalServiceImplementation) {
    await authService.init();
    }

    await authService.init();
    await bookService.init();
    await projectsService.init();
    await videosService.init();
    await storageService.init();
  } catch (e) {
    print('Local Storage Error: $e');
  }

  runApp(MainApp(
    storageService: storageService,
    isAuthenticated: isAuthenticated,
    )
  );
}

class MainApp extends StatelessWidget {
  final StorageService storageService;
  final bool isAuthenticated;

  const MainApp({super.key, required this.storageService, required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthStateCubit>(
          create: (_) => sl<AuthStateCubit>()..started(),
        ),
        BlocProvider<ChatRoomViewModel>(
          create: (_) => sl<ChatRoomViewModel>()..getRooms(),
        ),
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(storageService),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
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
            home: BlocBuilder<AuthStateCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated || isAuthenticated) {
                  return const LoginPage();
                }
                if (state is Unauthenticated) {
                  return const Register();
                }
                return const Register();
              },
            ),
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
