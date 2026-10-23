
import 'package:flutter/material.dart';
import '../main.dart';
import 'destination_page.dart';
import 'hotels_page.dart';
import 'experiences_page.dart';
import 'offers_page.dart';
import 'loginpage.dart';
import 'bookastay.dart';
import 'appfooter.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool menuOpen = false;

  static const Color navy = Color(0xFF0F1B2D);
  static const Color gold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFEBBA50);
  static const Color textGold = Color(0xFFBEA877);

  final List<Map<String, dynamic>> menuItems = [
     {'title': 'Home', 'page': const MainApp()},
    {'title': 'DESTINATION', 'page': const DestinationPage()},
    {'title': 'HOTELS', 'page': const HotelsPage()},
    {'title': 'EXPERIENCES', 'page': const ExperiencesPage()},
    {'title': 'OFFERS', 'page': const OffersPage()},
  ];

 void navigateToPage(Widget page) {
  setState(() => menuOpen = false);

  if (page is MainApp) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const MainApp(),
      ),
      (route) => false,
    );
    return;
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => PageWithNavbar(page: page),
    ),
  );
}

  Widget buildLogo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'BookMyStay',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: gold,
            letterSpacing: 1.2,
            fontFamily: 'Georgia',
          ),
        ),
        SizedBox(height: 3),
        Text(
          'YOUR STAY, YOUR LUXURY',
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w800,
            color: lightGold,
            letterSpacing: 1.4,
          ),
        ),
      ],
    );
  }

  Widget buildNavigation(double fontSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...menuItems.map(
          (item) => 
          TextButton(
            onPressed: () => 
            navigateToPage(item['page'] as Widget),
            style: TextButton.styleFrom(
              foregroundColor: textGold,
              padding: const EdgeInsets.symmetric(horizontal: 7),
            ),
            child: Text(
              item['title'] as String,
              style: TextStyle(
                fontSize: fontSize,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        ElevatedButton(
          onPressed: () => navigateToPage(const LoginPage()),
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'LOGIN / JOIN',
            style: TextStyle(fontSize: 10),
          ),
        ),
        const SizedBox(width: 6),
        ElevatedButton(
          onPressed: () => navigateToPage(const BookAStayPage()),
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'BOOK A STAY',
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget buildMobileMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in menuItems)
          TextButton(
            onPressed: () => navigateToPage(item['page'] as Widget),
            style: TextButton.styleFrom(
              foregroundColor: textGold,
              alignment: Alignment.centerLeft,
            ),
            child: Text(item['title'] as String),
          ),
        ElevatedButton(
          onPressed: () => navigateToPage(const LoginPage()),
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: Colors.white,
          ),
          child: const Text('LOGIN / JOIN'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => navigateToPage(const BookAStayPage()),
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: Colors.white,
          ),
          child: const Text('BOOK A STAY'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 650;
        final isTablet = width >= 650 && width < 1000;

        return Container(
          width: double.infinity,
          
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 20,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: navy,
            border: Border.all(color: gold, width: 0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildLogo(),
                  if (isMobile)
                    IconButton(
                      onPressed: () {
                        setState(() => menuOpen = !menuOpen);
                      },
                      icon: Icon(
                        menuOpen ? Icons.close : Icons.menu,
                        color: gold,
                        size: 28,
                      ),
                    )
                  else
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: buildNavigation(isTablet ? 9 : 10),
                      ),
                    ),
                ],
              ),
              if (isMobile && menuOpen) ...[
                const SizedBox(height: 12),
                const Divider(color: Color(0xFF66552B)),
                buildMobileMenu(),
              ],
            ],
          ),
        );
      },
    );
  }
}

class PageWithNavbar extends StatelessWidget {
  final Widget page;

  const PageWithNavbar({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F0),
      body: SafeArea(
        child: Column(
          children: [
            const Navbar(),

            Expanded(
              child: page,
            ),
          
          ],
        ),
      ),
    );
  }
}
