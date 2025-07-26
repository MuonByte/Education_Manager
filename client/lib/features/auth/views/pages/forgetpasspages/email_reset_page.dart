import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/common/widgets/auth_button.dart';
import 'package:client/core/theme/pallete.dart';
import 'package:client/core/utils/validators.dart';
import 'package:client/features/auth/data/model/forget_password_request.dart';
import 'package:client/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:client/features/auth/views/widgets/otp_dialog.dart';
import 'package:client/features/auth/views/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailResetPage extends StatefulWidget {
  const EmailResetPage({super.key});

  @override
  State<EmailResetPage> createState() => _EmailResetPageState();
}

class _EmailResetPageState extends State<EmailResetPage> {
  final _emailResetController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
                if(state is ButtonSuccessState){
                  showOtpDialog(
                    context,
                    _emailResetController.text,
                    isEmail: true,
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
                        'Enter Your Email',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                        ),
                      ),
        
                      SizedBox(height: spacing * 0.04),
        
                      CustomTextField(
                        controller: _emailResetController, 
                        hintText: "Email", 
                        prefixIcon: Icons.email,
                        validator: Validators.validateEmail,
                      ),
        
                      SizedBox(height: spacing * 0.04),
        
                      _resetPassButton(context, _formKey, _emailResetController),
                      
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
}

Widget _resetPassButton(BuildContext context, _formKey, TextEditingController _emailResetController) {
  return Builder(
    builder: (context) {
      return AuthButton(
        buttonText: 'Next',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<ButtonStateCubit>().excute(
              usecase: sl<ForgetPasswordUsecase>(),
              params: ForgetPasswordRequestParameters(
                value: _emailResetController.text,
                method: 'email',
              ),
            );
          }
        },
        backgroundColor: Pallete.darkPrimary,
      );
    },
  );
}

void showOtpDialog(BuildContext context, String contact, {required bool isEmail}) {
  showDialog(
    context: context,
    builder: (context) => OtpDialog(
      contact: contact,
      isEmail: isEmail,
    ),
  );
}

