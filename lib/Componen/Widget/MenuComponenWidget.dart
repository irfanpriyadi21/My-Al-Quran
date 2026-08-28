import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';


class MenuComponent extends StatelessWidget {
  final String? image;
  final String? title;
  final String? type;
  const MenuComponent(this.image, this.title, this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 48,
          alignment: Alignment.center,
          decoration: boxDecorationRoundedWithShadow(
            16,
            backgroundColor: context.cardColor,
            shadowColor: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.15),
          ),
          child: SizedBox(
            width: 28,
            height: 28,
            child: Image.asset(
              image!,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.mosque_outlined,
                  size: 22,
                  color: Colors.grey,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '$title',
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white70 : Colors.grey.shade700,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }
}
