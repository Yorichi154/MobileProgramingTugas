import 'package:flutter/material.dart';
import 'package:tugas_mobile_programing/pages/activity_intent_page.dart';
import 'package:tugas_mobile_programing/pages/camera_page.dart';
import 'package:tugas_mobile_programing/pages/google_maps_page.dart';
import 'package:tugas_mobile_programing/pages/home_page.dart';
import 'package:tugas_mobile_programing/pages/login_page.dart';
import 'package:tugas_mobile_programing/pages/main_page.dart';
import 'package:tugas_mobile_programing/pages/otp_page.dart';
import 'package:tugas_mobile_programing/pages/profil.page.dart';
import 'package:tugas_mobile_programing/pages/register_page.dart';
import 'package:tugas_mobile_programing/pages/settings_page.dart';
import 'package:tugas_mobile_programing/pages/stats_page.dart';
import 'package:tugas_mobile_programing/widgets/notification_badge.dart';
import 'package:tugas_mobile_programing/services/location_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _notificationCount = 3;
  final LocationService _locationService = LocationService();

  void _clearNotifications() {
    setState(() {
      _notificationCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: Colors.indigo,
        elevation: 2,
        actions: [
          IconButton(
            icon: NotificationBadge(count: _notificationCount),
            onPressed: _clearNotifications,
            tooltip: 'Notifikasi',
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _buildBodyContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfilPage()),
          );
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.person, color: Colors.white),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo, Colors.blue],
              ),
            ),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/1.jpg',
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Imam Mulana',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Premium Member',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(context, Icons.home, 'Beranda', null),
                _buildDrawerItem(
                    context, Icons.person, 'Profil', const ProfilPage()),
                _buildDrawerItem(
                    context, Icons.camera_alt, 'Kamera', const CameraPage()),
                _buildDrawerItem(
                    context, Icons.map, 'Google Maps', const GoogleMapsPage()),
                _buildDrawerItem(
                    context, Icons.bar_chart, 'Statistik', const StatsPage()),
                _buildDrawerItem(context, Icons.settings, 'Pengaturan',
                    const SettingsPage()),
                _buildDrawerItem(context, Icons.open_in_new,
                    'Activity & Intent', const ActivityIntentPage()),
                _buildDrawerItem(
                    context, Icons.login, 'Login', const LoginPage()),
                _buildDrawerItem(context, Icons.app_registration, 'Register',
                    const RegisterPage()),
                _buildDrawerItem(context, Icons.sms, 'OTP', const OtpPage()),
                _buildDrawerItem(
                    context, Icons.apps, 'Main Page', const MainPage()),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Keluar'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    Widget? destination, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title),
      onTap: onTap ??
          () {
            Navigator.pop(context);
            if (destination != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => destination));
            }
          },
    );
  }

  Widget _buildBodyContent() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Selamat Datang',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Apa yang ingin Anda lakukan hari ini?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildNavCard(
                  context,
                  Icons.camera_alt,
                  'Kamera',
                  const CameraPage(),
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.lightBlue],
                  ),
                ),
                _buildNavCard(
                  context,
                  Icons.map,
                  'Google Maps',
                  const GoogleMapsPage(),
                  gradient: const LinearGradient(
                    colors: [Colors.red, Colors.orange],
                  ),
                ),
                _buildNavCard(
                  context,
                  Icons.bar_chart,
                  'Statistik',
                  const StatsPage(),
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.deepPurpleAccent],
                  ),
                ),
                _buildNavCard(
                  context,
                  Icons.settings,
                  'Pengaturan',
                  const SettingsPage(),
                  gradient: const LinearGradient(
                    colors: [Colors.blueGrey, Colors.grey],
                  ),
                ),
                _buildNavCard(
                  context,
                  Icons.open_in_new,
                  'Activity & Intent',
                  const ActivityIntentPage(),
                  gradient: const LinearGradient(
                    colors: [Colors.pinkAccent, Colors.blueAccent],
                  ),
                ),
                _buildNavCard(
                  context,
                  Icons.login,
                  'Login',
                  const LoginPage(),
                  gradient: const LinearGradient(
                    colors: [Colors.teal, Colors.cyan],
                  ),
                ),
                _buildNavCard(
                  context,
                  Icons.app_registration,
                  'Register',
                  const RegisterPage(),
                  gradient: const LinearGradient(
                    colors: [Colors.deepOrange, Colors.amber],
                  ),
                ),
                _buildNavCard(
                  context,
                  Icons.sms,
                  'OTP',
                  const OtpPage(),
                  gradient: const LinearGradient(
                    colors: [Colors.indigo, Colors.purple],
                  ),
                ),
                _buildNavCard(
                  context,
                  Icons.apps,
                  'Main Page',
                  const MainPage(),
                  gradient: const LinearGradient(
                    colors: [Colors.brown, Colors.amber],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavCard(
    BuildContext context,
    IconData icon,
    String label,
    Widget? destination, {
    required Gradient gradient,
    VoidCallback? onTap,
  }) {
    return Hero(
      tag: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ??
              () {
                if (destination != null) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => destination));
                }
              },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: gradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.black26,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
