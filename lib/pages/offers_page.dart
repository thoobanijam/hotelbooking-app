
import 'package:flutter/material.dart';
 import 'package:hotelbooking_application_1/pages/appfooter.dart';
import 'package:hotelbooking_application_1/pages/offers_header.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Offers'),
        backgroundColor: const Color(0xFF0F1B2D),
        foregroundColor: const Color(0xFFD4AF37),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Exclusive Hotel Deals',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
            ),
          ),
          const SizedBox(height: 20),
          offerCard(
            'Weekend Escape',
            'Enjoy a relaxing weekend at selected hotels.',
            '15% OFF',
          ),
          offerCard(
            'Luxury Stay',
            'Special rates on selected luxury rooms.',
            '20% OFF',
          ),
          offerCard(
            'Extended Stay',
            'Save when you book a longer stay.',
            '10% OFF',
          ),
          const SizedBox(height: 30,),
          const OffersHeader(),
          const SizedBox(height: 30,),
            const AppFooter(),
        ],
      ),
    );
  }

  Widget offerCard(String title, String description, String discount) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(
          Icons.local_offer,
          color: Color(0xFFD4AF37),
          size: 34,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text('$description\n$discount'),
        ),
        isThreeLine: true,
        onTap: () {},
      ),
    );
  }
}
