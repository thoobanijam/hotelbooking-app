
import 'package:flutter/material.dart';

import 'pages/navbar.dart';
import 'pages/firstcomponent.dart';
import 'pages/thanks.dart';
import 'pages/appfooter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hotelbooking_application_1/pages/latestoffers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BookMyStayApp());
}

class BookMyStayApp extends StatelessWidget {
  const BookMyStayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookMyStay',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F6F0),
      ),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Navbar(),
              FirstComponent(),
              ThanksPage(),
               LatestOffersPage(),
              AppFooter(),
              
            ],
          ),
        ),
      ),
    );
  }
}
