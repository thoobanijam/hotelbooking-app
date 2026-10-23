
import 'package:flutter/material.dart';

class ExperienceHeader extends StatelessWidget {
  const ExperienceHeader({super.key});

  static const Color navy = Color(0xFF0F1B2D);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.workspace_premium,
            color: gold,
            size: 38,
          ),
          const SizedBox(height: 12),
          const Text(
            'UNFORGETTABLE MOMENTS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: gold,
              fontSize: 12,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Exceptional Experiences',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 65,
            height: 3,
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'From peaceful nature escapes to extraordinary '
            'adventures, discover special moments designed '
            'to make every stay memorable.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
