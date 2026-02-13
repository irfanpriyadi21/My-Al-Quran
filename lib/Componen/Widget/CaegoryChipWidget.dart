import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CategoryChip(String text, bool isActive, Color primaryColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: isActive ? primaryColor : Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: primaryColor),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isActive ? Colors.white : primaryColor,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}