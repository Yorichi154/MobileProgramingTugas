// lib/pages/activity_intent_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityIntentPage extends StatefulWidget {
  const ActivityIntentPage({super.key});

  @override
  State<ActivityIntentPage> createState() => _ActivityIntentPageState();
}

class _ActivityIntentPageState extends State<ActivityIntentPage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka URL')),
      );
    }
  }

  void _launchPhone(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka nomor telepon')),
      );
    }
  }

  void _launchEmail(String email) async {
    final Uri uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity & Intent'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bagian URL
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Masukkan URL',
                hintText: 'https://example.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _launchURL(_urlController.text),
              icon: const Icon(Icons.web),
              label: const Text('Buka Website'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 20),

            // Bagian Lokasi
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Lokasi',
                hintText: 'Jakarta, Indonesia',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _launchURL(
                  'https://www.google.com/maps/search/?api=1&query=${_locationController.text}'),
              icon: const Icon(Icons.location_on),
              label: const Text('Buka di Google Maps'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 20),

            // Bagian Telepon
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nomor Telepon',
                hintText: '08123456789',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _launchPhone(_phoneController.text),
              icon: const Icon(Icons.phone),
              label: const Text('Hubungi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 20),

            // Bagian Email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Email',
                hintText: 'example@example.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _launchEmail(_emailController.text),
              icon: const Icon(Icons.email),
              label: const Text('Kirim Email'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
