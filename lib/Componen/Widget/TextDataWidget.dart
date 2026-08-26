import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextData extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const TextData({
    Key? key,
    required this.text,
    this.size = 16,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
