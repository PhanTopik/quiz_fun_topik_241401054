import 'package:flutter/material.dart';
import '../Services/theme_service.dart';

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
    final textColor = Theme.of(context).colorScheme.onSurface;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.themeNotifier,
      builder: (context, currentThemeMode, child) {
        final platformBrightness = MediaQuery.platformBrightnessOf(context);
        final isDarkMode = currentThemeMode == ThemeMode.dark ||
            (currentThemeMode == ThemeMode.system && platformBrightness == Brightness.dark);

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
            title: Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                fontSize: screenWidth * 0.032,
                color: textColor.withValues(alpha: 0.6),
              ),
            ),
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
      },
    );
  }
}