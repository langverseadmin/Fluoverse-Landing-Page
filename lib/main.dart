// lib/landing_page/landing_main.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'landing_page/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pjjiusivnjtpzzqlhpzd.supabase.co',   // 🔥 Replace with your own
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqaml1c2l2bmp0cHp6cWxocHpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUzMzg1MjQsImV4cCI6MjA2MDkxNDUyNH0.8IgVvZh8taOnnoMVtuTMFt5njnuhdMdI138nPiBq1Fs',                       // 🔥 Replace with your own
  );
  runApp(const LandingMainApp());
}

class LandingMainApp extends StatelessWidget {
  const LandingMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluoverse - Learn the Language by Living It',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
