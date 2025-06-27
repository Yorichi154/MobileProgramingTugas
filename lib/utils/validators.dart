/// Kumpulan validator untuk form-field
class FormValidators {
  /// Validator untuk email
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  /// Validator untuk password
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
    if (value.length < 8) return 'Password minimal 8 karakter';
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Harus mengandung huruf besar';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Harus mengandung angka';
    }
    return null;
  }

  /// Validator untuk nomor telepon Indonesia
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty)
      return 'Nomor telepon tidak boleh kosong';
    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
    if (!cleaned.startsWith('0') && !cleaned.startsWith('+62')) {
      return 'Format nomor tidak valid';
    }
    if (cleaned.length < 10 || cleaned.length > 14) {
      return 'Panjang nomor tidak valid';
    }
    return null;
  }

  /// Validator untuk konfirmasi password
  static String? confirmPassword(String? value, String password) {
    if (value != password) return 'Password tidak sama';
    return null;
  }

  /// Validator untuk required field
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} tidak boleh kosong';
    }
    return null;
  }
}
