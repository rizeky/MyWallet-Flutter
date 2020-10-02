import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainColor = const Color(0xFF6200EE);
Color accentColor = const Color(0xFF03DAC5);
Color blackColor = const Color(0xFF505152);
Color whiteColor = const Color(0xFFFFFFFF);

TextStyle blueTitle = GoogleFonts.ptSans(
    color: mainColor, fontSize: 24, fontWeight: FontWeight.bold);

TextStyle whiteTitle = GoogleFonts.ptSans(
    color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold);

TextStyle blackSubtitle = GoogleFonts.ptSans(
    color: blackColor, fontSize: 18, fontWeight: FontWeight.normal);

TextStyle blueSubtitle = GoogleFonts.ptSans(
    color: mainColor, fontSize: 18, fontWeight: FontWeight.bold);

TextStyle whiteSubtitle = GoogleFonts.ptSans(
    color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold);

TextStyle blackContentRegular = GoogleFonts.ptSans(
    color: blackColor, fontSize: 16, fontWeight: FontWeight.normal);