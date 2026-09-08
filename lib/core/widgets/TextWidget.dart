import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/App_Colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign textAlign;
  final TextOverflow textflow;
  final int maxline;
  final double space;
  static FontWeight normal_text = FontWeight.normal;
  static FontWeight Medium_text = FontWeight.w500;
  static FontWeight Bold_text = FontWeight.w600;
  static FontWeight ExtraBold_text = FontWeight.w700;
  TextWidget({required this.text,required this.size, required this.weight,this.color = AppColors.textPrimary,this.textAlign = TextAlign.start , this.textflow = TextOverflow.visible,this.maxline = 1,this.space = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: color,
          fontSize: size,
          fontWeight: weight,
          letterSpacing: space
      ));
  }
}
