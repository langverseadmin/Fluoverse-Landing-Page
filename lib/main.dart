// lib/landing_page/landing_main.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../website/screens/homepage.dart'; // 👈 Make sure this matches your file structure

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pjjiusivnjtpzzqlhpzd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqaml1c2l2bmp0cHp6cWxocHpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY4MjI2NTgsImV4cCI6MjA2MjM5ODY1OH0.OAhCRxjORCDmoBDipAc-GkLqp7xe8Tn2LV_sIoDXCqU',
  );
  runApp(const FluoverseWebsiteApp());
}

class FluoverseWebsiteApp extends StatelessWidget {
  const FluoverseWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluoverse – Speak-First AI Language Tutor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent, // for gradient visibility
      ),
      home: const HomePage(), // 👈 This now launches your full website homepage
    );
  }
}
