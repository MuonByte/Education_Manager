import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/common/widgets/custom_button.dart';
import 'package:client/core/helper/helper_functions.dart';
import 'package:client/features/auth/data/model/forget_password_request.dart';
import 'package:client/features/auth/data/model/verify_otp_request.dart';
import 'package:client/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:client/features/auth/domain/usecases/verifyotp_usecase.dart';
import 'package:client/features/auth/views/pages/forgetpasspages/reset_password_page.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpDialog extends StatefulWidget {
  final String contact;
  final bool isEmail;
  const OtpDialog({super.key, required this.contact, required this.isEmail});

  @override
  _OtpDialogState createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String get _enteredOtp => _controllers.map((controller) => controller.text).join();

  final _verifyCubit = ButtonStateCubit();
  final _resendCubit = ButtonStateCubit();

  @override
  void dispose() {
    _verifyCubit.close();
    _resendCubit.close();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ButtonStateCubit>.value(value: _verifyCubit),
        BlocProvider<ButtonStateCubit>.value(value: _resendCubit),
      ],
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Text('Verify', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8),
              Text(
                'We Have Sent Code To Your Given Contact Info',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              SizedBox(height: 4),
              Text(
                widget.isEmail ? maskEmail(widget.contact) : maskPhoneNumber(widget.contact),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: 50,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20),
                      maxLength: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: "",
                      ),
                      onChanged: (value) {
                        if (value.length == 1 && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: 24),

              BlocListener<ButtonStateCubit, ButtonState>(
                bloc: _verifyCubit,
                listener: (context, state) {
                  if (state is ButtonSuccessState) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPasswordPage(
                          value: widget.contact,
                          method: widget.isEmail ? 'email' : 'phone',
                          otp: _enteredOtp,
                        ),
                      ),
                    );
                  } else if (state is ButtonFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                },
                child: CustomButton(
                  buttonText: 'Verify',
                  onPressed: () {
                    if (_enteredOtp.length == 6) {
                      _verifyCubit.excute(
                        usecase: sl<VerifyotpUsecase>(),
                        params: VerifyOtpRequest(
                          value: widget.contact,
                          method: widget.isEmail ? 'email' : 'phone',
                          otp: _enteredOtp,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter the 6-digit OTP')),
                      );
                    }
                  },
                  backgroundColor: Colors.black,
                ),
              ),

              SizedBox(height: 12),

              BlocListener<ButtonStateCubit, ButtonState>(
                bloc: _resendCubit,
                listener: (context, state) {
                  if (state is ButtonSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("OTP re-sent")),
                    );
                  } else if (state is ButtonFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                },
                child: CustomButton(
                  buttonText: 'Send Again',
                  onPressed: () {
                    _resendCubit.excute(
                      usecase: sl<ForgetPasswordUsecase>(),
                      params: ForgetPasswordRequestParameters(
                        value: widget.contact,
                        method: widget.isEmail ? 'email' : 'phone',
                      ),
                    );
                  },
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
