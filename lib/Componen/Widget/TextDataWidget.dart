import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextData extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const TextData({
    super.key,
    required this.text,
    this.size = 16,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? Colors.white : Colors.black;

    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: size,
          color: color ?? defaultColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
