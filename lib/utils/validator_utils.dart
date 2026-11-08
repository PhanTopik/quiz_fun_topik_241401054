class ValidatorUtils {
  // Fungsi untuk memvalidasi format email sesuai dengan nama@gmail.com
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Fungsi untuk memeriksa apakah password kosong atau tidak
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}