import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/core/utils/validators.dart';
import 'package:client/features/auth/data/model/register_request.dart';
import 'package:client/features/auth/domain/usecases/signup_usecase.dart';
import 'package:client/features/auth/viewmodel/bloc/auth/auth_state.dart';
import 'package:client/features/auth/viewmodel/bloc/auth/auth_state_cubit.dart';
import 'package:client/features/auth/views/pages/login_page.dart';
import 'package:client/common/widgets/custom_button.dart';
import 'package:client/common/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/pages/verfy%20pages/email_verify_page.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/features/auth/views/widgets/ordivider.dart';
import 'package:client/features/auth/views/widgets/otp_dialog.dart';
import 'package:client/features/auth/views/widgets/social_buttons.dart';
import 'package:client/features/profile/views/pages/profile_page.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = MediaQuery.of(context).size.height;
    final double iconspace = 20;

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ButtonStateCubit()),
            BlocProvider(create: (context) => AuthStateCubit(sl(), sl())),
          ],
          child: BlocListener<AuthStateCubit, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                showOtpDialog(
                  context,
                  _emailController.text,
                  isEmail: true,
                );
              } else if (state is Unauthenticated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Registration failed. Please try again.")),
                );
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
                        'Create your\nAccount',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins',
                        ),
                      ),

                      SizedBox(height: spacing * 0.04),

                      _nameField(),

                      SizedBox(height: spacing * 0.01),

                      _emailField(),

                      SizedBox(height: spacing * 0.01),

                      _passwordField(),

                      SizedBox(height: spacing * 0.025),

                      _registerButton(context),

                      SizedBox(height: spacing * 0.02),

                      _changeMethod(context),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      OrDivider(),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      Center(
                        child: Text(
                          'Continue With Accounts',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(height: spacing * 0.02),

                      _otherRegister(iconspace, theme),
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

  CustomTextField _nameField() {
    return CustomTextField(
      controller: _nameController,
      hintText: 'Name',
      prefixIcon: Icons.person_2_outlined,
      validator: (value) =>
          Validators.validateUsername(value),
    );
  }

  CustomTextField _emailField() {
    return CustomTextField(
      controller: _emailController,
      hintText: 'Email',
      prefixIcon: Icons.email_outlined,
      validator: (value) => Validators.validateEmail(value),
    );
  }

  CustomTextField _passwordField() {
    return CustomTextField(
      controller: _passwordController,
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
      validator: (value) =>
          Validators.validatePassword(value),
    );
  }

  Row _changeMethod(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already Have An Account?',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          child: Text(
            ' Sign In',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _otherRegister(double iconspace, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButtons(
          mainIcon: Icons.email,
          gradColor1: Colors.red,
          gradColor2: const Color.fromARGB(
            255,255,171,171,
          ),
          mainColor: Colors.red,
        ),

        SizedBox(width: iconspace),

        SocialButtons(
          mainIcon: Icons.phone_android_rounded,
          gradColor1: theme.colorScheme.onSurface,
          gradColor2: theme.colorScheme.surface,
          mainColor: theme.colorScheme.onSurface,
        ),
      
      ],
    );
  }

  Widget _registerButton(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(
      builder: (context) {
        return CustomButton(
          buttonText: 'Register',
          backgroundColor: theme.colorScheme.primary,
          onPressed: () {
            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
              context.read<AuthStateCubit>().signup(
                SignupRequestParameters(
                  email: _emailController.text,
                  password: _passwordController.text,
                  username: _nameController.text,
                ),
                sl<SignupUsecases>(),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please fill all fields correctly.")),
              );
            }
          },
        );
      },
    );
  }
}

void showOtpDialog(BuildContext context, String contact, {required bool isEmail}) {
  showDialog(
    context: context,
    builder: (context) => OtpDialog(
      contact: contact,
      isEmail: isEmail,
      isFromRegister: true,
    ),
  );
}