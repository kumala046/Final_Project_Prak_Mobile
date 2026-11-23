import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/splash_screen.dart';
import 'services/notification_service.dart';
import 'models/favorite_show.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);

  await Supabase.initialize(
    url: 'https://ekyzvgrqmcthugakpvgy.supabase.co',
    anonKey: 'sb_publishable__oM_IvEUvWU2b_gDwHwtVA_GtZ_ZLAb',
  );

  // Inisialisasi Hive
  await Hive.initFlutter(); 

  // Registrasi adapter FavoriteShow
  Hive.registerAdapter(FavoriteShowAdapter()); 

  // Membuka box untuk menyimpan data favorit
  await Hive.openBox<FavoriteShow>('favorites'); 

  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Srimanganti App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F5F0),
        primaryColor: const Color(0xFF1A3C2F),
        fontFamily: 'serif',
      ),
      home: const SplashScreen(),
    );
  }
}