import 'package:aifer_task/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.height, required this.text, required this.textSize,
  });
  final double height;
  final double textSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Pallete.secondoryColor),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.roboto(fontSize: textSize),
        ),
      ),
    );
  }
}