import 'package:flutter/material.dart';

class AISection extends StatelessWidget {
  final String text;
  const AISection({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 235, 235),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/icon/app_icon.png', width: 55, color: Colors.black,),
              const SizedBox(width: 8),
              const Spacer(),
              const Icon(Icons.copy, size: 20),
              const SizedBox(width: 12),
              const Icon(Icons.share, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
  
}
