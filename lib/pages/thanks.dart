
import 'package:flutter/material.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({super.key});

  static const Color navy = Color(0xFF0F1B2D);
  static const Color gold = Color(0xFFD4AF37);
  static const Color champagne = Color(0xFFBEA877);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 50,
      ),
      color: const Color(0xFFFAF8F3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'BOOKMYSTAY',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: navy,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
              fontFamily: 'Georgia',
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'YOUR STAY, YOUR LUXURY',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: champagne,
              fontSize: 10,
              letterSpacing: 3,
            ),
          ),

          const SizedBox(height: 35),

          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: gold.withValues(alpha: 0.12),
              border: Border.all(
                color: gold,
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: gold,
              size: 46,
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'THANK YOU',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: champagne,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Thank You For Being\nPart Of This Journey',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Georgia',
              color: navy,
              fontSize: 32,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 22),

          Container(
            height: 2,
            width: 75,
            color: gold,
          ),

          const SizedBox(height: 28),

          const Text(
            'Every journey tells a story, and we are grateful '
            'that you chose BookMyStay to be a part of yours.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF555555),
              fontSize: 16,
              height: 1.8,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Your trust inspires us to create exceptional stays, '
            'unforgettable experiences, and beautiful memories. '
            'Whether you travel for relaxation, adventure, or a '
            'special occasion, your comfort and happiness matter '
            'to us.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
              height: 1.9,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: navy,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_rounded,
                  color: gold,
                  size: 35,
                ),
                SizedBox(height: 14),
                Text(
                  'You Make Our Journey Special',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    color: gold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Thank you for being part of the BookMyStay '
                  'family. We look forward to welcoming you again '
                  'and making your next stay memorable.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.8,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'WITH GRATITUDE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: champagne,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'BookMyStay',
            style: TextStyle(
              fontFamily: 'Georgia',
              color: navy,
              fontSize: 28,
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Your Stay, Your Luxury.',
            style: TextStyle(
              color: Color(0xFF777777),
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
