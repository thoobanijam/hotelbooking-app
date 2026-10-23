import 'package:flutter/material.dart';

class FirstComponent extends StatelessWidget {
  const FirstComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text(
                          'DISCOVER YOUR NEXT ESCAPE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 3,
                            color: Color(0xFFA58003),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Stay Somewhere Extraordinary',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            height: 1.3,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Georgia',
                            color: Color(0xFF0F1B2D),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Discover exceptional hotels and unforgettable experiences.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      
               
                      ],
                    ),
                  );
                    
                  
  }
}
