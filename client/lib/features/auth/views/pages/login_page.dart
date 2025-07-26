import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/domain/usecases/login_usecase.dart';
import 'package:client/features/auth/views/pages/forgetpasspages/forget_password_page.dart';
import 'package:client/features/auth/views/pages/register_page.dart';
import 'package:client/common/widgets/auth_button.dart';
import 'package:client/features/auth/views/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/features/auth/views/widgets/ordivider.dart';
import 'package:client/features/auth/views/widgets/social_buttons.dart';
import 'package:client/features/profile/views/pages/profile_page.dart';
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
    //final borderspace = MediaQuery.of(context).size.height;
    final spacing = MediaQuery.of(context).size.height;
    final double iconspace = 20;
    //String backgroundAsset = responsiveplatform(context);

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        body: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if(state is ButtonSuccessState){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => ProfilePage())
                );
              }
              if(state is ButtonFailureState){
                var snackbar = SnackBar(content: Text(state.errorMessage));
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
            
                      const Text(
                        'Login your\nAccount',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
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
            
                      const Center(
                        child: Text(
                          'Continue With Accounts',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
            
                      SizedBox(height: spacing * 0.02),
            
                      _otherLogin(iconspace),
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
            child: const Text(
              'Forget Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget _changeMethods(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Dont Have An Account?',
          style: TextStyle(
            color: Colors.grey,
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
          child: const Text(
            ' Sign Up',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _otherLogin(double iconspace) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButtons(
          gradColor1: Colors.blueAccent,
          gradColor2: Colors.cyanAccent,
          mainColor: Colors.blue,
          mainIcon: Icons.facebook_sharp,
        ),

        SizedBox(width: iconspace),

        SocialButtons(
          mainIcon: Icons.email,
          gradColor1: Colors.red,
          gradColor2: const Color.fromARGB(255, 255, 171, 171),
          mainColor: Colors.red,
        ),

        SizedBox(width: iconspace),

        SocialButtons(
          mainIcon: Icons.phone_android,
          gradColor1: const Color.fromARGB(255, 233, 233, 233),
          gradColor2: const Color.fromARGB(255, 112, 112, 112),
          mainColor: const Color.fromARGB(255, 197, 197, 197),
        ),
      ],
    );
  }

  Widget _loginButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return AuthButton(
          buttonText: 'Login',
          backgroundColor: Colors.black,
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
