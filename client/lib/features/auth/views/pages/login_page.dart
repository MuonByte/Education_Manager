import 'package:client/core/theme/pallete.dart';
import 'package:client/core/utils/responsiveplatform.dart';
import 'package:client/features/auth/views/pages/register.dart';
import 'package:client/features/auth/views/widgets/auth_button.dart';
import 'package:client/features/auth/views/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/features/auth/views/widgets/ordivider.dart';
import 'package:client/features/auth/views/widgets/social_button.dart';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';


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
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
  final spacing = MediaQuery.of(context).size.height;
  String backgroundAsset = responsiveplatform(context);

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
                    'Login your\nAccount',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  
                  SizedBox(height: spacing * 0.04),
          
                  CustomTextField(
                    controller: emailController, 
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                  ),
          
                  SizedBox(height: spacing * 0.01),
          
                  CustomTextField(
                    controller: passwordController, 
                    hintText: 'Password', 
                    prefixIcon: Icons.lock_outline_rounded,
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
                    buttonText: 'Login',
                    onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Placeholder()),
                      );
                    }
                  ),
          
                  SizedBox(height: spacing * 0.02),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont Have An Account?',
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
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
                  ),
          
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          
                  OrDivider(),
          
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          
                  const Center(
                    child: Text(
                      'Continue With Accounts',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ),
                  
                  SizedBox(height: spacing * 0.02),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SocialButton(
                          backgroundColor: Colors.red.shade100, 
                          mainText: 'GOOGLE', 
                          textColor: Colors.red
                        ),
                      ),
                      
                      SizedBox(width: 16),
                      
                      Expanded(
                        child: SocialButton(
                          backgroundColor: Colors.blue.shade100, 
                          mainText: 'FACEBOOK', 
                          textColor: Colors.blue
                        ),
                      ),
                    ],
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
