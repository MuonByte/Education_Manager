import 'package:client/core/theme/theme.dart';
import 'package:client/features/theme/model/storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';



class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final StorageService storageService;
  ThemeBloc(this.storageService)
      : super(ThemeState(AppTheme.lightTheme)) {
    _loadInitialTheme();
    on<ToggleThemeEvent>((event, emit) async {
      final newTheme =
          event.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
      await storageService.saveThemePreference(event.isDarkMode);
      emit(ThemeState(newTheme));
    });
  }
  Future<void> _loadInitialTheme() async {
    final isDarkMode = await storageService.getThemePreference();
    add(ToggleThemeEvent(isDarkMode));
  }
}