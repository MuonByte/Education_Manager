import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/core/utils/validators.dart';
import 'package:client/features/auth/data/model/register_request.dart';
import 'package:client/features/auth/domain/usecases/signup_usecase.dart';
import 'package:client/features/auth/views/pages/login_page.dart';
import 'package:client/common/widgets/auth_button.dart';
import 'package:client/features/auth/views/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/features/auth/views/widgets/ordivider.dart';
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
    //final borderspace = MediaQuery.of(context).size.height;
    final spacing = MediaQuery.of(context).size.height;
    final double iconspace = 20;
    //String backgroundAsset = responsiveplatform(context);

    return Form(
      key: _formKey,
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
                        'Create your\nAccount',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
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

                      _otherRegister(iconspace),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already Have An Account?',
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
                builder: (context) => LoginPage(),
              ),
            );
          },
          child: const Text(
            ' Sign In',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _otherRegister(double iconspace) {
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
          gradColor2: const Color.fromARGB(
            255,
            255,
            171,
            171,
          ),
          mainColor: Colors.red,
        ),

        SizedBox(width: iconspace),

        SocialButtons(
          mainIcon: Icons.apple,
          gradColor1: Colors.white,
          gradColor2: const Color.fromARGB(
            255,
            112,
            112,
            112,
          ),
          mainColor: Colors.white,
        ),
      
      ],
    );
  }

  Widget _registerButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return AuthButton(
          buttonText: 'Register',
          backgroundColor: Colors.black,
          onPressed: () {
          if (_formKey.currentState != null && _formKey.currentState!.validate()) {
            context.read<ButtonStateCubit>().excute(
              usecase: sl<SignupUsecases>(),
              params: SignupRequestParameters(
                email: _emailController.text,
                password: _passwordController.text,
                username: _nameController.text,
              ),
            );
          } else {
            context.read<ButtonStateCubit>().emit(
              ButtonFailureState(errorMessage: "Please fill all fields correctly."),
            );
          }
        },
        );
      },
    );
  }
}
