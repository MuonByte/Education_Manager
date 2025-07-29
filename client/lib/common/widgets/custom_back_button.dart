import 'package:client/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: PhysicalModel(
        color: Pallete.WhiteColor,
        shadowColor: Colors.black.withOpacity(0.4),
        elevation: 6,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } 
            else {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Icon(Icons.arrow_back_ios_outlined)
          ),
        ),
      ),
    );
  }
}

