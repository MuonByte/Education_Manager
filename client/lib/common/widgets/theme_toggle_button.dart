import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/features/theme/viewmodel/theme_bloc.dart';
import 'package:client/features/theme/viewmodel/theme_event.dart';
import 'package:client/features/theme/viewmodel/theme_state.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeData.brightness == Brightness.dark;

        return IconButton(
          iconSize: 30,
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleThemeEvent(!isDark));
          },
          tooltip: 'Toggle Theme',
          color: theme.colorScheme.surfaceContainer,
        );
      },
    );
  }
}
