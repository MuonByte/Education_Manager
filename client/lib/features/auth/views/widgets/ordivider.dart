import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
=======
    return Padding(
      padding: const EdgeInsets.all(10),
>>>>>>> 662dd4f63f199a0b6a5ba308ae1a46240b1955be
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: Color.fromARGB(255, 126, 126, 126), // or a soft gray/white
              thickness: 1,
            ),
          ),
        ]
      ),
    );
  }
}
