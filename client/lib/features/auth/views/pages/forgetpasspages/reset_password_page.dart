import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/common/widgets/custom_button.dart';
import 'package:client/features/auth/data/model/reset_password_requset.dart';
import 'package:client/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:client/common/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/features/profile/views/pages/profile_page.dart';
import 'package:client/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  final String value;
  final String method; 
  final String otp;

  const ResetPasswordPage({
    super.key,
    required this.value,
    required this.method,
    required this.otp,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _resetPasswordController = TextEditingController();
  final _cResetPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.height;

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
                        'Reset Your\nPassword',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                        ),
                      ),

                      SizedBox(height: spacing * 0.04),

                      _newpassfield(),

                      SizedBox(height: spacing * 0.01),

                      //_confirmnewpass(),

                      SizedBox(height: spacing * 0.025),

                      _resetbutton(context),
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

  Widget _resetbutton(BuildContext context) {
    return Builder(
      builder: (context) {
        return CustomButton(
          buttonText: 'Reset Password',
          backgroundColor: Colors.black,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ButtonStateCubit>().excute(
                usecase: sl<ResetPasswordUsecase>(),
                params: ResetPasswordRequestParameters(
                  value: widget.value,
                  method: widget.method,
                  otp: widget.otp,
                  newPassword: _resetPasswordController.text,
                ),
              );
            }
            else {
            context.read<ButtonStateCubit>().emit(
              ButtonFailureState(errorMessage: "An Error has Occured"),
            );
          }
          },
        );
      }
    );
  }

/*   Widget _confirmnewpass() {
    return CustomTextField(
      controller: _cResetPasswordController,
      hintText: 'Confirm Password',
      prefixIcon: Icons.lock_open_outlined,
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
  } */

  Widget _newpassfield() {
    return CustomTextField(
      controller: _resetPasswordController,
      hintText: 'New Password',
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
}
