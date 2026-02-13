import 'package:flutter/material.dart';

import 'TextDataWidget.dart';

Widget SurahCard({
  required int number,
  required String title,
  required String subtitle,
  required String arabic,
  required Color primaryColor,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:  const BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
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
        SizedBox(width: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/image/ayat.png',
                height: 40),
            TextData(
              text: "$number",
              size: 10,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
        const SizedBox(width: 16),
        /// TITLE
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextData(
                text: title,
                size: 14,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 4),
              TextData(
                text: subtitle,
                size: 10,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),

        /// ARABIC
        TextData(
          text: arabic,
          size: 18,
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),

      ],
    ),
  );
}
