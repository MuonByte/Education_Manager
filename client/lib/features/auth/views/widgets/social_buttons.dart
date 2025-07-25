import 'dart:ui';
import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  final Color gradColor1;
  final Color gradColor2;
  final Color mainColor;
  final IconData mainIcon;

  const SocialButtons({
    super.key, 
    required this.gradColor1, 
    required this.gradColor2, 
    required this.mainColor, 
    required this.mainIcon,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradColor1, gradColor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: mainColor.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(
        mainIcon,
        size: 40,
        color: const Color.fromARGB(115, 0, 0, 0),
      ),
    );
  }
}