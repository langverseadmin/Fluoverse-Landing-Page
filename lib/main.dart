import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

import 'landing_page/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch Supabase credentials securely from your backend
  final response = await http.get(
    Uri.parse('https://fluoverse.onrender.com/auth/init'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load Supabase config from backend');
  }

  final config = json.decode(response.body);
  final supabaseConfig = config['supabase'];

  await Supabase.initialize(
    url: supabaseConfig['url'],
    anonKey: supabaseConfig['anon_key'],
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
