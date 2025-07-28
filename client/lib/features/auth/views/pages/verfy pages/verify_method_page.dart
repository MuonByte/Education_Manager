import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/common/widgets/custom_button.dart';
import 'package:client/core/theme/pallete.dart';
import 'package:client/features/auth/views/pages/verfy%20pages/email_verify_page.dart';
import 'package:client/features/auth/views/pages/verfy%20pages/phone_verify_page.dart';
import 'package:client/features/auth/views/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/features/auth/views/widgets/selectable_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyMethodPage extends StatefulWidget {
  const VerifyMethodPage({super.key});

  @override
  State<VerifyMethodPage> createState() => _VerifyMethodPageState();
}

class _VerifyMethodPageState extends State<VerifyMethodPage> {
  String selectedMethod = '';

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
              if(state is ButtonSuccessState){
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => Placeholder())
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
                      'Verify Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const Text(
                      'Select which contact details should we use to verify your account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Poppins',
                      ),
                    ),

                    SizedBox(height: spacing * 0.04),

                    SelectableCard(
                      selected: selectedMethod == 'email',
                      icon: Icons.email,
                      title: 'Email',
                      subtitle: 'Send Code to your email',
                      onTap: () {
                        setState(() {
                          selectedMethod = 'email';
                        });
                      },
                    ),

                    SizedBox(height: spacing * 0.02),

                    SelectableCard(
                      selected: selectedMethod == 'phone',
                      icon: Icons.phone,
                      title: 'Phone',
                      subtitle: 'Send Code to your phone',
                      onTap: () {
                        setState(() {
                          selectedMethod = 'phone';
                        });
                      },
                    ),

                    SizedBox(height: spacing * 0.05),

                    _nextButton(context, selectedMethod),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _nextButton(BuildContext context, String selectedMethod) {
  return CustomButton(
    buttonText: 'Next',
    onPressed: () {
      if (selectedMethod.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a method')),
        );
        return;
      }
      if (selectedMethod == 'email') {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => EmailVerifyPage())
        );
      } else if (selectedMethod == 'phone') {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => PhoneVerifyPage())
        );
      }
    },
    backgroundColor: Pallete.darkPrimary,
  );
}
