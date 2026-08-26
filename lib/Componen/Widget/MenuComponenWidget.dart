import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';


class MenuComponent extends StatelessWidget {
  final String? image;
  final String? title;
  final String? type;
  const MenuComponent(this.image, this.title, this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 50,
          alignment: Alignment.center,
          decoration: boxDecorationRoundedWithShadow(
            16,
            backgroundColor: context.cardColor,
            shadowColor: Colors.grey.withOpacity(0.2),
          ),
          child: SizedBox(
            width: 30,
            height: 30,
            child: Image.asset(
              image!,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  size: 22,
                  color: Colors.grey,
                );
              },
            ),
          ),
        ),
        8.height,
        Expanded(
          child: Text(
            '$title',
            style: GoogleFonts.poppins(
                textStyle: secondaryTextStyle
                  (
                    size: 12,
                    color: Colors.grey
                )
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
