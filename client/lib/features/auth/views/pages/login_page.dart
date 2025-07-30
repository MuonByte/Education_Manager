import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/domain/usecases/login_usecase.dart';
import 'package:client/features/auth/views/pages/forgetpasspages/forget_password_page.dart';
import 'package:client/features/auth/views/pages/register_page.dart';
import 'package:client/common/widgets/custom_button.dart';
import 'package:client/common/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/pages/verfy%20pages/verify_method_page.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/features/auth/views/widgets/ordivider.dart';
import 'package:client/features/auth/views/widgets/social_buttons.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = MediaQuery.of(context).size.height;
    final double iconspace = 20;

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if(state is ButtonSuccessState){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => HomePage())
                );
              }
              if(state is ButtonFailureState){
                var snackbar = SnackBar(content: Text(state.errorMessage), backgroundColor: theme.colorScheme.error,);
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBackButton(),
            
                      SizedBox(height: spacing * 0.07),
            
                      Text(
                        'Login your\nAccount',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins',
                        ),
                      ),
            
                      SizedBox(height: spacing * 0.04),
            
                      _emailField(),
            
                      SizedBox(height: spacing * 0.01),
            
                      _passwordField(),

                      SizedBox(height: spacing * 0.015),

                      _forgetPassword(context),
            
                      SizedBox(height: spacing * 0.015),
            
                      _loginButton(context),
            
                      SizedBox(height: spacing * 0.02),
            
                      _changeMethods(context),
            
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
                      OrDivider(),
            
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
                      Center(
                        child: Text(
                          'Continue With Accounts',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
            
                      SizedBox(height: spacing * 0.02),
            
                      _otherLogin(iconspace, theme),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgetPassword(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [ 
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgetPasswordPage(),
                ),
              );
            },
            child: Text(
              'Forget Password',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget _changeMethods(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Dont Have An Account?',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Register(),
              ),
            );
          },
          child: Text(
            ' Sign Up',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _otherLogin(double iconspace, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButtons(
          mainIcon: Icons.email,
          gradColor1: Colors.red,
          gradColor2: const Color.fromARGB(255, 255, 171, 171),
          mainColor: Colors.red,
        ),

        SizedBox(width: iconspace),

        SocialButtons(
          mainIcon: Icons.phone_android,
          gradColor1: theme.colorScheme.onSurface,
          gradColor2: theme.colorScheme.surface,
          mainColor: theme.colorScheme.onSurface,
        ),
      ],
    );
  }

  Widget _loginButton(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(
      builder: (context) {
        return CustomButton(
          buttonText: 'Login',
          backgroundColor: theme.colorScheme.primary,
          onPressed: () {
            context.read<ButtonStateCubit>().excute(
              usecase: sl<LoginUsecase>(),
              params: LoginRequestParameters(
                email: emailController.text, 
                password: passwordController.text
              )
            );
          },
        );
      }
    );
  }

  Widget _passwordField() {
    return CustomTextField(
      controller: passwordController,
      hintText: 'Password',
      prefixIcon: Icons.lock_outline_rounded,
      obscureText: _obscurePassword,
      suffixIconWidget: IconButton(
        icon: Icon(
          _obscurePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
        onPressed: _togglePasswordVisibility,
      ),
    );
  }

  Widget _emailField() {
    return CustomTextField(
      controller: emailController,
      hintText: 'Email',
      prefixIcon: Icons.email_outlined,
    );
  }
}
