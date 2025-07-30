import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/widgets/custom_button.dart';
import 'package:client/features/auth/domain/entities/user_entity.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/features/auth/domain/usecases/logout_usecase.dart';
import 'package:client/features/auth/views/pages/login_page.dart';
import 'package:client/features/profile/data/model/delete_account_request.dart';
import 'package:client/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:client/features/profile/viewmodel/bloc/delete_account_cubit.dart';
import 'package:client/features/profile/viewmodel/bloc/user_display_cubit.dart';
import 'package:client/features/profile/viewmodel/bloc/user_display_state.dart';
import 'package:client/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          BlocProvider(create: (context) => ButtonStateCubit()),
          BlocProvider(create: (context) => DeleteAccountCubit()), // Add DeleteAccountCubit
        ],
        child: MultiBlocListener( // Use MultiBlocListener for multiple listeners
          listeners: [
            BlocListener<ButtonStateCubit, ButtonState>(
              listener: (context, state) {
                if(state is ButtonSuccessState) {
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => LoginPage())
                  );
                }
              },
            ),
            BlocListener<DeleteAccountCubit, ButtonState>( // Listener for DeleteAccountCubit
              listener: (context, state) {
                if (state is ButtonSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Account deleted successfully!")),
                  );
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => LoginPage())
                  );
                } else if (state is ButtonFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to delete account: ${state.errorMessage}")),
                  );
                }
              },
            ),
          ],
          child: Center(
            child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return Image.asset(
                    'assets/gifs/Nothing.gif'
                  );
                }
                if (state is UserLoaded) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _username(state.userEntity, theme),
                        _email(state.userEntity, theme),
                        _logout(context, theme),
                        _deleteAccount(context, theme), // Add delete account button
                      ],
                    ),
                  );
                }
                if (state is LoadUserFailure) {
                  return Text(state.errorMessage);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _username(UserEntity user, ThemeData theme) {
    return Text(
      user.username,
      style: theme.textTheme.bodyLarge,
    );
  }

  Widget _email(UserEntity user, ThemeData theme) {
    return Text(
      user.email,
      style: theme.textTheme.bodyMedium,
    );
  }

  Widget _logout(BuildContext context, ThemeData theme) {
    return CustomButton(
      buttonText: 'Logout',
      backgroundColor: theme.colorScheme.secondary.withOpacity(0.3),
      onPressed: () {
        context.read<ButtonStateCubit>().excute(usecase: sl<LogoutUsecase>());
      },
    );
  }

  Widget _deleteAccount(BuildContext context, ThemeData theme) {
    final TextEditingController _passwordController = TextEditingController();
    return CustomButton(
      buttonText: 'Delete Account',
      backgroundColor: theme.colorScheme.error,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Confirm Account Deletion'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Are you sure you want to delete your account? This action cannot be undone.'),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
                TextButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    if (_passwordController.text.isNotEmpty) {
                      context.read<DeleteAccountCubit>().deleteAccount(
                            sl<DeleteAccountUsecase>(),
                            DeleteAccountRequestParameters(
                              password: _passwordController.text,
                            ),
                          );
                      Navigator.of(dialogContext).pop();
                    } else {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(content: Text('Please enter your password.')),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
