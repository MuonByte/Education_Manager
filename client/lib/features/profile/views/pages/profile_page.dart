import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/widgets/auth_button.dart';
import 'package:client/features/auth/domain/entities/user_entity.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/features/auth/domain/usecases/logout_usecase.dart';
import 'package:client/features/auth/views/pages/login_page.dart';
import 'package:client/features/profile/viewmodel/bloc/user_display_cubit.dart';
import 'package:client/features/profile/viewmodel/bloc/user_display_state.dart';
import 'package:client/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          BlocProvider(create: (context) => ButtonStateCubit()),
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if(state is ButtonSuccessState) {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => LoginPage())
              );
            }
          },
          child: Center(
            child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is UserLoaded) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _username(state.userEntity),
                        _email(state.userEntity),
                        _logout(context),
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

  Widget _username(UserEntity user) {
    return Text(
      user.username,
      style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
    );
  }

  Widget _email(UserEntity user) {
    return Text(
      user.email,
      style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
    );
  }

  Widget _logout(BuildContext context) {
    return AuthButton(
      buttonText: 'Logout',
      backgroundColor: Colors.black38,
      onPressed: () {
        context.read<ButtonStateCubit>().excute(usecase: sl<LogoutUsecase>());
      },
    );
  }
}
