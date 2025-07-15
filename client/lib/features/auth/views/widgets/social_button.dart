import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String mainText;
  final Color textColor;
  final Color backgroundColor;
  
  const SocialButton({super.key, required this.backgroundColor, required this.mainText, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        mainText,
        style: TextStyle(
          color: textColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: 3,
        ),
      ),
    );
  }
}