import 'package:client/common/widgets/auth_button.dart';
import 'package:client/features/auth/views/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final resetPasswordController = TextEditingController();
  final cResetPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
      key: formKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
          
                  CustomTextField(
                    controller: resetPasswordController, 
                    hintText: 'New Password', 
                    prefixIcon: Icons.lock_outline_rounded,
                    obscureText: _obscurePassword,
                    suffixIconWidget: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),

                  SizedBox(height: spacing * 0.01),

                  CustomTextField(
                    controller: cResetPasswordController, 
                    hintText: 'Confirm Password', 
                    prefixIcon: Icons.lock_open_outlined,
                    obscureText: _obscurePassword,
                    suffixIconWidget: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),

                  SizedBox(height: spacing * 0.025),
          
                  AuthButton(
                    buttonText: 'Reset Password',
                    backgroundColor: Colors.black,
                    onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Placeholder()),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}