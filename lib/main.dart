import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:krishi_mitra/screens/chat_screen.dart';
import 'app/app_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';



Future<void> main() async {
  await Supabase.initialize(
    url: 'https://hjsmluvgdmucwkkyhywo.supabase.co',
    anonKey: 'sb_publishable_QOrq0c4ZOdP_At2-Kd3jCw_JHy_qR3L',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(KrushiMitraApp());
}

class KrushiMitraApp extends StatelessWidget {
  const KrushiMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KrushiMitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087F5B),
        ),
        useMaterial3: true,
      ),
      // home: const AppNavigation(),
      home: const AppNavigation(),
    );
  }
}