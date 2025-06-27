import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final String _validOtp = '123456';

  @override
  void initState() {
    super.initState();
    _autoFillOtp();
  }

  @override
  void dispose() {
    otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _autoFillOtp() async {
    // Simulasi OTP diterima otomatis setelah 1 detik
    await Future.delayed(const Duration(seconds: 1));
    otpController.text = _validOtp;
    _verifyOtp();
  }

  void _verifyOtp() {
    String enteredOtp = otpController.text.trim();

    if (enteredOtp.isEmpty) {
      _showMessage('Kode OTP tidak boleh kosong');
      return;
    }

    if (enteredOtp == _validOtp) {
      _showToast('✅ OTP valid!');
      // Navigasi ke halaman home setelah valid
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      });
    } else {
      _showMessage('OTP salah!');
    }
  }

  void _showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verifikasi OTP")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Masukkan kode OTP yang dikirim ke ponsel Anda:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: otpController,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: "Kode OTP",
                border: OutlineInputBorder(),
                counterText: '',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _verifyOtp,
                icon: const Icon(Icons.verified),
                label: const Text("Verifikasi Manual"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
