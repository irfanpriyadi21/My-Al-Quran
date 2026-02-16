import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class CardComponen extends StatelessWidget {
  final String? image;
  final String? text;
  final String? text2;
  const CardComponen(this.image, this.text, this.text2,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: boxDecorationRoundedWithShadow(
        20,
        backgroundColor: Colors.white,
        blurRadius: 10.0,
        spreadRadius: 4.0,
        shadowColor:Colors.grey[300],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
            height: 90,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              "$image",
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.image,
                  size: 40,
                );
              },
            ),
          ),
          Container(
            height: 80,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    text!.length > 40
                        ? text!.substring(0, 40) + '...'
                        : text!,
                    style: GoogleFonts.poppins(
                        textStyle: boldTextStyle(size: 12)
                    )),
                const SizedBox(height: 8),
                Text(
                    text2!.length > 50
                        ? text2!.substring(0, 50) + '...'
                        : text2!,
                    style: GoogleFonts.poppins(
                        textStyle: secondaryTextStyle(size: 10)
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
