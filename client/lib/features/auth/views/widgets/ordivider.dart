import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
