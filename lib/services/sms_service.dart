import 'package:flutter_sms/flutter_sms.dart';

class SmsService {
  Future<void> sendMessage(String message, List<String> recipients) async {
    try {
      String result = await sendSMS(
        message: message,
        recipients: recipients,
      );
      print('SMS sent: $result');
    } catch (error) {
      print('Failed to send SMS: $error');
    }
  }
}
