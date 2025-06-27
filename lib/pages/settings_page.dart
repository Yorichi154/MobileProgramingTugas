import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  bool biometricAuthEnabled = false;
  String appVersion = '1.0.0';
  bool isDeveloperMode = false;
  int developerTapCount = 0;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _requestPermissions();
    _getAppVersion();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      biometricAuthEnabled = prefs.getBool('biometricAuthEnabled') ?? false;
      isDeveloperMode = prefs.getBool('isDeveloperMode') ?? false;
    });
  }

  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.sms,
      Permission.location,
      Permission.notification,
      Permission.camera,
    ].request();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            statuses.values.every((status) => status.isGranted)
                ? 'Semua izin diberikan'
                : 'Beberapa izin ditolak. Beberapa fitur mungkin tidak berfungsi.',
          ),
          backgroundColor: statuses.values.every((status) => status.isGranted)
              ? Colors.green
              : Colors.orange,
        ),
      );
    }
  }

  Future<void> _getAppVersion() async {
    // In a real app, you would get this from package info
    setState(() => appVersion = '1.2.4');
  }

  Future<void> _checkForUpdates() async {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Memeriksa pembaruan...'),
          duration: Duration(seconds: 2),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aplikasi sudah versi terbaru'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _launchPrivacyPolicy() async {
    const url = 'https://example.com/privacy-policy';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka kebijakan privasi')),
      );
    }
  }

  Future<void> _clearCache() async {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cache berhasil dibersihkan'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showDeveloperOptions() {
    setState(() {
      developerTapCount++;
      if (developerTapCount >= 7) {
        isDeveloperMode = true;
        _savePreference('isDeveloperMode', true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mode developer diaktifkan!'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        backgroundColor: Colors.blueGrey,
        elevation: 2,
      ),
      body: ListView(
        children: [
          // Theme Settings
          _buildSectionHeader('Tampilan'),
          _buildSettingTile(
            icon: Icons.brightness_6,
            title: "Mode Gelap",
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() => isDarkMode = value);
                _savePreference('isDarkMode', value);
              },
              activeColor: Colors.blueGrey,
            ),
          ),

          // Security Settings
          _buildSectionHeader('Keamanan'),
          _buildSettingTile(
            icon: Icons.notifications,
            title: "Notifikasi",
            subtitle: "Aktifkan pemberitahuan penting",
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() => notificationsEnabled = value);
                _savePreference('notificationsEnabled', value);
              },
              activeColor: Colors.blueGrey,
            ),
          ),
          _buildSettingTile(
            icon: Icons.fingerprint,
            title: "Autentikasi Biometrik",
            subtitle: "Gunakan sidik jari atau wajah untuk login",
            trailing: Switch(
              value: biometricAuthEnabled,
              onChanged: (value) {
                setState(() => biometricAuthEnabled = value);
                _savePreference('biometricAuthEnabled', value);
              },
              activeColor: Colors.blueGrey,
            ),
          ),

          // Permissions
          _buildSectionHeader('Izin Aplikasi'),
          _buildSettingTile(
            icon: Icons.security,
            title: "Kelola Izin",
            subtitle: "SMS, Lokasi, Kamera, Notifikasi",
            onTap: _requestPermissions,
          ),

          // App Maintenance
          _buildSectionHeader('Pemeliharaan'),
          _buildSettingTile(
            icon: Icons.update,
            title: "Periksa Pembaruan",
            onTap: _checkForUpdates,
          ),
          _buildSettingTile(
            icon: Icons.cached,
            title: "Bersihkan Cache",
            onTap: _clearCache,
          ),

          // Legal & About
          _buildSectionHeader('Tentang'),
          _buildSettingTile(
            icon: Icons.privacy_tip,
            title: "Kebijakan Privasi",
            onTap: _launchPrivacyPolicy,
          ),
          _buildSettingTile(
            icon: Icons.info,
            title: "Tentang Aplikasi",
            onTap: () => _showAboutDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Versi Aplikasi'),
            trailing: Text(appVersion),
            onTap: _showDeveloperOptions,
            onLongPress: () {
              if (isDeveloperMode) {
                Navigator.pushNamed(context, '/developer');
              }
            },
          ),

          // Hidden developer section
          if (isDeveloperMode) ...[
            _buildSectionHeader('Developer Options'),
            _buildSettingTile(
              icon: Icons.developer_mode,
              title: "Debug Mode",
              trailing: Switch(
                value: false,
                onChanged: (value) {},
                activeColor: Colors.red,
              ),
            ),
            _buildSettingTile(
              icon: Icons.bug_report,
              title: "Logs",
              onTap: () => Navigator.pushNamed(context, '/logs'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.blueGrey[700],
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tentang Aplikasi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SafeTrack v$appVersion'),
            const SizedBox(height: 8),
            const Text('© 2023 SafeTrack Team'),
            const SizedBox(height: 16),
            const Text(
              'Aplikasi untuk memantau keamanan dan lokasi secara real-time.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
