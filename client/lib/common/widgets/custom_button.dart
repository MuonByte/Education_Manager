import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/common/bloc/button/button_state_cubit.dart';
import 'package:client/common/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color backgroundColor; 
  final ButtonStateCubit? buttonCubit; // New optional parameter

  const CustomButton({
    super.key, 
    required this.buttonText, 
    required this.onPressed,
    required this.backgroundColor,
    this.buttonCubit, // Initialize new parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: BlocBuilder<ButtonStateCubit,ButtonState>(
        bloc: buttonCubit, // Use the provided cubit, or null for default
        builder: (context, state) {
          if(state is ButtonLoadingState){
            return _loading(context);
          }
          return _inital(context);
        }
      )
    );
  }

  Widget _loading(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      child: CircularProgressIndicator()
    );
  }

  Widget _inital(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontFamily: 'Poppins',
        ),
      )
    );
  }
}