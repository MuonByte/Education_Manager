import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/common/widgets/custom_button.dart';
import 'package:client/core/theme/pallete.dart';
import 'package:client/core/utils/validators.dart';
import 'package:client/features/auth/data/model/send_otp_request.dart';
import 'package:client/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:client/features/auth/views/pages/otp_dialog.dart';
import 'package:client/common/widgets/custom_back_button.dart';
import 'package:client/features/auth/views/widgets/custom_text_field.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneVerifyPage extends StatefulWidget {
  const PhoneVerifyPage({super.key});

  @override
  State<PhoneVerifyPage> createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  String selectedMethod = '';
  final _phoneNumberController = TextEditingController();
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
                    _phoneNumberController.text,
                    isEmail: false,
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
                        'Enter Your Phone\nNumber',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                        ),
                      ),
        
                      SizedBox(height: spacing * 0.04),
        
                      CustomTextField(
                        controller: _phoneNumberController, 
                        hintText: "Phone Number", 
                        prefixIcon: Icons.phone_callback,
                        validator: Validators.validatePhoneNumber,
                      ),
        
                      SizedBox(height: spacing * 0.04),
        
                      _verifyButton(context, _formKey, _phoneNumberController),
                      
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

Widget _verifyButton(BuildContext context, _formKey, TextEditingController _phoneNumberController) {
  return Builder(
    builder: (context) {
      return CustomButton(
        buttonText: 'Next',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<ButtonStateCubit>().excute(
              usecase: sl<SendOtpUsecase>(),
              params: SendOtpRequestParameters(
                value: _phoneNumberController.text,
                method: 'phone',
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
