import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Config/routes.dart';
import '../Services/user_service.dart';
import '../Widgets/app_scaffold.dart';
import '../utils/snackbar_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String fromRoute;
  const ForgotPasswordScreen({
    super.key,
    this.fromRoute = 'signin',
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Controller untuk mengelola input teks email dan password baru
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  int _currentStep = 1;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Fungsi untuk memvalidasi apakah email yang dimasukkan terdaftar
  Future<void> _verifyEmail() async {
    final inputEmail = _emailController.text.trim();
    if (inputEmail.isEmpty) {
      SnackbarUtils.showSnackBar(context: context, message: 'Harap masukkan email Anda!', backgroundColor: Colors.red);
      return;
    }

    final savedEmail = await UserService.getSavedEmail();

    if (!mounted) return;

    if (savedEmail == null || inputEmail != savedEmail) {
      SnackbarUtils.showSnackBar(context: context, message: 'Email tidak terdaftar!', backgroundColor: Colors.red);
      return;
    }

    // Jika valid, lanjutkan ke langkah kedua
    setState(() {
      _currentStep = 2;
    });
  }

  // Fungsi untuk memvalidasi dan menyimpan password baru pengguna
  Future<void> _resetPassword() async {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      SnackbarUtils.showSnackBar(context: context, message: 'Harap masukkan password baru!', backgroundColor: Colors.red);
      return;
    }

    if (newPassword != confirmPassword) {
      SnackbarUtils.showSnackBar(context: context, message: 'Konfirmasi password tidak cocok!', backgroundColor: Colors.red);
      return;
    }

    // Memperbarui password melalui user service
    await UserService.updatePassword(newPassword);

    if (!mounted) return;

    SnackbarUtils.showSnackBar(context: context, message: 'Password berhasil diubah!', backgroundColor: Colors.green);
    _navigateBack();
  }

  // Fungsi untuk menangani navigasi kembali berdasarkan dari rute mana halaman
  void _navigateBack() {
    if (widget.fromRoute == 'profile') {
      context.go(AppRoutes.profile);
    } else {
      context.go(AppRoutes.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _navigateBack,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.04),
            // Judul langkah 1 dan langkah 2
            Text(
              _currentStep == 1 ? 'Cari Akun Anda' : 'Buat Password Baru',
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.01),
            // Subjudul instruksi langkah 1 dan langkah 2
            Text(
              _currentStep == 1
                  ? 'Masukkan email terdaftar untuk melanjutkan pemulihan password.'
                  : 'Masukkan kata sandi baru untuk akun Anda.',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: textColor.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.05),

            if (_currentStepForm()) ...[
              // Langkah 1: Input Email untuk verifikasi
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Terdaftar',
                  prefixIcon: Icon(Icons.email, color: textColor),
                ),
                style: TextStyle(color: textColor),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  onPressed: _verifyEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34A853),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                  ),
                  child: Text(
                    'Verifikasi Email',
                    style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ] else ...[
              // Langkah 2: Input Password Baru & Konfirmasi
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                  prefixIcon: Icon(Icons.lock_outline, color: textColor),
                ),
                style: TextStyle(color: textColor),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password Baru',
                  prefixIcon: Icon(Icons.lock, color: textColor),
                ),
                style: TextStyle(color: textColor),
              ),
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  onPressed: _resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34A853),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                  ),
                  child: Text(
                    'Simpan Password Baru',
                    style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],

            SizedBox(height: screenHeight * 0.02),

            // Tombol Kembali berwarna merah
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.065,
              child: ElevatedButton.icon(
                onPressed: _navigateBack,
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                label: Text(
                  'Kembali',
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD34343),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi helper untuk memeriksa apakah sedang berada di langkah pertama
  bool _currentStepForm() {
    return _currentStep == 1;
  }
}