import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIconWidget;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIconWidget,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.surfaceContainer
      ),
      decoration: InputDecoration(
        isDense: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerLow,

        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 12),
          child: Icon(prefixIcon, color: theme.colorScheme.surfaceContainer,),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        suffixIcon: suffixIconWidget,

        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          color: theme.colorScheme.surfaceContainer
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.surfaceContainer,
            width: 2,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.surfaceContainer,
            width: 2,
          ),
        ),
      ),
    );
  }
}
