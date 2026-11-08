import 'package:flutter/material.dart';

class QuizCardWidget extends StatelessWidget {
  final String title;
  final String matakuliah;
  final String imagePath;
  final int totalQuestions;
  final VoidCallback onTap;

  const QuizCardWidget({
    super.key,
    required this.title,
    required this.matakuliah,
    required this.imagePath,
    required this.totalQuestions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Mengambil warna langsung dari app_theme yang sedang aktif
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Warna kartu dan border ditentukan berdasarkan tema aplikasi
    final cardBgColor = theme.cardColor;
    final borderColor = isDarkMode ? Colors.white.withValues(alpha: 0.15) : Colors.grey.withValues(alpha: 0.2);
    final textColor = theme.colorScheme.onSurface;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Gambar kartu quiz
              SizedBox(
                height: screenWidth * 0.28,
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                      child: Icon(Icons.image, color: Colors.grey.shade500, size: screenWidth * 0.08),
                    );
                  },
                ),
              ),

              // Bagian Informasi Judul dan Label
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.036,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                          height: 1.2,
                        ),
                      ),

                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [
                          // Label Mata Kuliah
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenWidth * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode ? const Color(0xFF137333).withValues(alpha: 0.2) : const Color(0xFFE2F4E2),
                              borderRadius: BorderRadius.circular(screenWidth * 0.015),
                            ),
                            child: Text(
                              matakuliah,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: screenWidth * 0.026,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? const Color(0xFF81C995) : theme.colorScheme.primary,
                              ),
                            ),
                          ),

                          // Label Total Soal
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenWidth * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode ? const Color(0xFF137333).withValues(alpha: 0.2) : const Color(0xFFE2F4E2),
                              borderRadius: BorderRadius.circular(screenWidth * 0.015),
                            ),
                            child: Text(
                              '$totalQuestions Soal',
                              style: TextStyle(
                                fontSize: screenWidth * 0.026,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? const Color(0xFF81C995) : theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}