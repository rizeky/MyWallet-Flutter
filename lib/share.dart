import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

Color mainColor = const Color(0xFF6200EE);
Color accentColor = const Color(0xFF03DAC5);
Color blackColor = const Color(0xFF505152);
Color whiteColor = const Color(0xFFFFFFFF);

TextStyle blueTitle = TextStyle(
    color: mainColor, fontSize: 24, fontWeight: FontWeight.bold);

TextStyle whiteTitle = TextStyle(
    color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold);

TextStyle blackSubtitle = TextStyle(
    color: blackColor, fontSize: 18, fontWeight: FontWeight.bold);

TextStyle blueSubtitle = TextStyle(
    color: mainColor, fontSize: 18, fontWeight: FontWeight.bold);

TextStyle whiteSubtitle = TextStyle(
    color: whiteColor, fontSize: 18, fontWeight: FontWeight.normal);

TextStyle blackContentRegular = TextStyle(
    color: blackColor, fontSize: 16, fontWeight: FontWeight.normal);

TextStyle whiteContentRegular = TextStyle(
    color: whiteColor, fontSize: 16, fontWeight: FontWeight.normal);

TextStyle whiteNum = TextStyle(
    color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold);

TextStyle blackNum = TextStyle(
    color: blackColor, fontSize: 18, fontWeight: FontWeight.bold);

String convertCurrRP(int value) {
  final NumberFormat formatCurrency = NumberFormat.simpleCurrency(name: 'IDR', decimalDigits: 0);
  return formatCurrency.format(value);
}