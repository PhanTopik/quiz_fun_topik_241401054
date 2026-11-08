import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Config/routes.dart';
import '../Services/user_service.dart';
import '../Widgets/app_scaffold.dart';
import '../utils/snackbar_utils.dart';
import '../utils/validator_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controller untuk mengelola input email dan password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk memvalidasi input dan memproses autentikasi login pengguna
  Future<void> _loginUser() async {
    final inputEmail = _emailController.text.trim();
    final inputPassword = _passwordController.text;

    // Memvalidasi apakah kolom input kosong
    if (!ValidatorUtils.isNotEmpty(inputEmail) || !ValidatorUtils.isNotEmpty(inputPassword)) {
      SnackbarUtils.showSnackBar(
        context: context,
        message: 'Mohon masukkan Email dan Password terlebih dahulu!',
        backgroundColor: Colors.red,
      );
      return;
    }

    // Memvalidasi format penulisan email
    if (!ValidatorUtils.isValidEmail(inputEmail)) {
      SnackbarUtils.showSnackBar(
        context: context,
        message: 'Format email tidak valid!',
        backgroundColor: Colors.red,
      );
      return;
    }

    final savedEmail = await UserService.getSavedEmail();
    final savedPassword = await UserService.getSavedPassword();

    // Memeriksa apakah akun terdaftar
    if (savedEmail == null || savedPassword == null) {
      if (mounted) {
        SnackbarUtils.showSnackBar(
          context: context,
          message: 'Akun anda tidak terdaftar',
          backgroundColor: Colors.red,
        );
      }
      return;
    }

    // Mencocokkan input pengguna dengan data yang tersimpan
    if (inputEmail == savedEmail && inputPassword == savedPassword) {
      if (mounted) {
        context.go(AppRoutes.home);
      }
    } else {
      if (mounted) {
        SnackbarUtils.showSnackBar(
          context: context,
          message: 'Email atau Password salah!',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final textColor = Theme.of(context).colorScheme.onSurface;

    return AppScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          final maxWidth = isLargeScreen ? 400.0 : constraints.maxWidth;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.1),

                    // Judul
                    Text(
                      'Selamat Datang Kembali!',
                      style: TextStyle(
                        fontSize: screenWidth * (isLargeScreen ? 0.06 : 0.1),
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    // Subjudul
                    Text(
                      'Sign in akun anda',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                        color: textColor.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: screenHeight * 0.05),

                    // Kotak Input Email
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: textColor,
                          size: screenWidth * 0.06,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.025,
                          horizontal: screenWidth * 0.055,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: textColor,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Kotak Input Password
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: textColor,
                          size: screenWidth * 0.06,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: textColor,
                            size: screenWidth * 0.06,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.025,
                          horizontal: screenWidth * 0.055,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: textColor,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    // Tautan halamab lupa Kata Sandi (Forgot Password)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.blue.shade300,
                          ),
                        ),
                        onPressed: () {
                          context.go(AppRoutes.forgotPassword);
                        },
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Tombol Sign In
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.075,
                      child: ElevatedButton(
                        onPressed: _loginUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.withValues(alpha: 0.8),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Tautan Navigasi ke sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: textColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go(AppRoutes.signUp);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}