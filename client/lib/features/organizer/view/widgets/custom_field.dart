import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData customicon;

  const CustomField({
    super.key, 
    required this.hintText,
    required this.controller,
    required this.customicon,
    }
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Color.fromARGB(255, 102, 102, 102)),
      decoration: InputDecoration(
        fillColor: theme.inputDecorationTheme.fillColor,
        prefixIcon: Icon(customicon, color: theme.colorScheme.surfaceContainerHigh),
        hintText: hintText,
        hintStyle: TextStyle(color: theme.hintColor),
        border: InputBorder.none,
      ),
    );
  }
}