//import 'package:client/core/utils/responsiveplatform.dart';
import 'package:client/features/auth/views/pages/reset_password_page.dart';
import 'package:client/features/auth/views/pages/register_page.dart';
import 'package:client/common/widgets/auth_button.dart';
import 'package:client/features/auth/views/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/features/auth/views/widgets/ordivider.dart';
import 'package:client/features/auth/views/widgets/social_buttons.dart';

import 'package:flutter/material.dart';


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
  
  //final borderspace = MediaQuery.of(context).size.height;
  final spacing = MediaQuery.of(context).size.height;
  final double iconspace = 20;
  //String backgroundAsset = responsiveplatform(context);

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
                    backgroundColor: Colors.black,
                    onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPasswordPage()),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
      
                      SocialButtons(
                        gradColor1: Colors.blueAccent, 
                        gradColor2: Colors.cyanAccent,
                        mainColor: Colors.blue, 
                        mainIcon: Icons.facebook_sharp),

                      SizedBox(width: iconspace,),
      
                      SocialButtons(
                        mainIcon: Icons.email,
                        gradColor1: Colors.red,
                        gradColor2: const Color.fromARGB(255, 255, 171, 171),
                        mainColor: Colors.red,
                      ),
      
                      SizedBox(width: iconspace,),

                      SocialButtons(
                        mainIcon: Icons.phone_android,
                        gradColor1: const Color.fromARGB(255, 184, 184, 184),
                        gradColor2: const Color.fromARGB(255, 112, 112, 112),
                        mainColor: const Color.fromARGB(255, 184, 184, 184),
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
