import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Formatter untuk input mata uang Rupiah
class CurrencyInputFormatter extends TextInputFormatter {
  final String symbol;

  CurrencyInputFormatter({this.symbol = 'Rp '});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final cleanText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    final numValue = int.tryParse(cleanText) ?? 0;

    final formattedText = NumberFormat.currency(
      locale: 'id_ID',
      symbol: symbol,
      decimalDigits: 0,
    ).format(numValue);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// Formatter untuk nomor telepon Indonesia
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^\d+]'), '');

    if (text.startsWith('0')) {
      return TextEditingValue(
        text: text.replaceAllMapped(
          RegExp(r'(\d{3})(\d{3})(\d{4})'),
          (match) => '${match[1]} ${match[2]} ${match[3]}',
        ),
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    } else if (text.startsWith('+62')) {
      return TextEditingValue(
        text: text.replaceAllMapped(
          RegExp(r'(\+62)(\d{3})(\d{3})(\d{3})'),
          (match) => '${match[1]} ${match[2]} ${match[3]} ${match[4]}',
        ),
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    }
    return newValue;
  }
}

/// Formatter untuk input tanggal (dd/MM/yyyy)
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.length > 8) return oldValue;

    String formattedText = text;
    if (text.length > 4) {
      formattedText =
          '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4)}';
    } else if (text.length > 2) {
      formattedText = '${text.substring(0, 2)}/${text.substring(2)}';
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
