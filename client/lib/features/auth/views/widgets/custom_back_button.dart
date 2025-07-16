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
<<<<<<< HEAD
        shadowColor: Colors.black.withOpacity(0.4),
=======
        shadowColor: Colors.black.withOpacity(0.3),
>>>>>>> 662dd4f63f199a0b6a5ba308ae1a46240b1955be
        elevation: 6,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {Navigator.pop(context);},
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

