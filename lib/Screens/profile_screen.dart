import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Config/routes.dart';
import '../Widgets/app_scaffold.dart';
import '../Widgets/profile_button.dart';
import '../Widgets/profile_switch_button.dart';
import '../Widgets/ganti_nama_dialog.dart';
import '../Services/user_service.dart';
import '../Services/theme_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Loading...';
  String _userEmail = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await UserService.getName();
    final email = await UserService.getEmail();
    setState(() {
      _userName = name;
      _userEmail = email;
    });
  }

  Future<void> _gantiNama() async {
    await gantiNamaDialog(
      context: context,
      currentName: _userName,
      onNameUpdated: (newName) {
        setState(() {
          _userName = newName;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final textColor = Theme.of(context).colorScheme.onSurface;

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.06,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),

            // Profile Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                children: [
                  Container(
                    width: screenWidth * 0.25,
                    height: screenWidth * 0.25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: textColor.withValues(alpha: 0.3),
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        fit: BoxFit.cover,
                        width: screenWidth * 0.25,
                        height: screenWidth * 0.25,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: Icon(Icons.person, size: screenWidth * 0.12, color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Nama akun
                  Text(
                    _userName,
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.005),

                  // Email akun
                  Text(
                    _userEmail,
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      color: textColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            // tombol Ganti nama akun
            ProfileButton(
              icon: Icons.person_outline,
              title: 'Ganti nama',
              subtitle: 'Update your display name',
              onTap: _gantiNama,
            ),

            SizedBox(height: screenHeight * 0.01),

            // tombol Ganti password akun
            ProfileButton(
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Update your account password',
              onTap: () {
                context.go(AppRoutes.forgotPassword);
              },
            ),

            SizedBox(height: screenHeight * 0.01),

            // Fitur Dark/Light Mode
            ProfileSwitchButton(
              icon: Icons.brightness_6_outlined,
              title: 'Mode Gelap',
              subtitle: 'Aktifkan tampilan tema gelap',
              value: isDarkMode,
              onChanged: (bool value) {
                ThemeService.setThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),

            SizedBox(height: screenHeight * 0.03),

            // Logout akun
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: ElevatedButton.icon(
                onPressed: () {
                  context.go(AppRoutes.signIn);
                },
                icon: Icon(
                  Icons.logout,
                  size: screenWidth * 0.05,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD34343),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.018,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  elevation: 0,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}