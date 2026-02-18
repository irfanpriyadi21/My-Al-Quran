import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'TextDataWidget.dart';

class VerseShareCard extends StatelessWidget {
  final String arabic;
  final String latin;
  final String translation;
  final int number;

  const VerseShareCard({
    super.key,
    required this.arabic,
    required this.latin,
    required this.translation,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF134E5E),
            Color(0xFF1F6F78),
            Color(0xFF71B280),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextData(
            text: arabic,
            size: 28,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),

          const SizedBox(height: 10),

          TextData(
            text: latin,
            size: 13,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 10),

          Text(
            translation,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "Verse $number • My Quran App",
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
