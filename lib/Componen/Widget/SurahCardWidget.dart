import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/Surah/quran_settings_provider.dart';
import 'TextDataWidget.dart';

class SurahCard extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  final String arabic;
  final Color primaryColor;
  final VoidCallback? onInfoTap;

  const SurahCard({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.arabic,
    required this.primaryColor,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/image/Vector.png', height: 40),
              TextData(
                text: "$number",
                size: 12,
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(width: 16),

          /// TITLE & SUBTITLE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextData(
                  text: title,
                  size: 15,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 4),
                TextData(
                  text: subtitle,
                  size: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),

          /// ARABIC & INFO ACTION
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<QuranSettingsProvider>(
                builder: (context, quranSettings, _) {
                  return Text(
                    arabic,
                    style: quranSettings.getArabicTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  );
                },
              ),
              if (onInfoTap != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: isDark ? Colors.white38 : Colors.grey.shade400,
                  ),
                  tooltip: "Info Surah",
                  onPressed: onInfoTap,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
