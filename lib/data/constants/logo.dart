// Suggested code may be subject to a license. Learn more: ~LicenseLog:754200422.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLogo extends StatelessWidget {
  final Color? color;
  final double? fontSize;
  const TextLogo({super.key,required this.color,required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return  Text('Diet Hut',style: GoogleFonts.satisfy(fontSize: fontSize,color: color),);
  }
}
