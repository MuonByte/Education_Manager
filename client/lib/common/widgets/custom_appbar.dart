import 'package:client/common/widgets/custom_back_button.dart';
import 'package:client/features/theme/viewmodel/theme_bloc.dart';
import 'package:client/features/theme/viewmodel/theme_event.dart';
import 'package:client/features/theme/viewmodel/theme_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      elevation: 2,
      actions: [
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final isDarkMode = state.themeData.brightness == Brightness.dark;
            return Row(
              children: [
                CustomBackButton(isAuth: true,),
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    context.read<ThemeBloc>().add(ToggleThemeEvent(value));
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
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
          CustomBackButton(),
          const SizedBox(width: 12),
          const Text(
            'Organizer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,fontFamily: 'Poppins'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
