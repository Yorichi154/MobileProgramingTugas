import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/otp_page.dart';
import 'pages/profil.page.dart';
import 'pages/camera_page.dart';
import 'pages/google_maps_page.dart';
import 'pages/settings_page.dart';
import 'pages/stats_page.dart';
import 'pages/activity_intent_page.dart';

void main() {
  // Enable Flutter web engine
  setUrlStrategy(PathUrlStrategy());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Mobile ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.indigo,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: '/', // Initial route
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/otp': (context) => const OtpPage(),
        '/profile': (context) => const ProfilPage(),
        '/camera': (context) => const CameraPage(),
        '/google-maps': (context) => const GoogleMapsPage(),
        '/settings': (context) => const SettingsPage(),
        '/stats': (context) => const StatsPage(),
        '/activity-intent': (context) => const ActivityIntentPage(),
      },
      // Handle unknown routes
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
            child: Text('Page not found: ${settings.name}'),
          ),
        ),
      ),
    );
  }
}
