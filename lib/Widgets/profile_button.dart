import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // untuk mengambil tema aktif
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    // Menentukan warna latar belakang dan border berdasarkan tema
    final containerBg = isDarkMode
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.03);

    final borderColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.15)
        : Colors.black.withValues(alpha: 0.08);

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
      decoration: BoxDecoration(
        color: containerBg,
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: ListTile(
        // Icon
        leading: Container(
          padding: EdgeInsets.all(screenWidth * 0.025),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          child: Icon(
            icon,
            color: Colors.blue,
            size: screenWidth * 0.05,
          ),
        ),
        // Judul utama menu
        title: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        // Subjudul keterangan menu
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w200,
            color: textColor.withValues(alpha: 0.6),
          ),
        ),
        // Icon panah di sebelah kanan
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: textColor.withValues(alpha: 0.5),
          size: screenWidth * 0.04,
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.005,
        ),
      ),
    );
  }
}