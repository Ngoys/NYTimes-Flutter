// ignoreforfile: constant_identifier_names, non_constant_identifier_names, unusedfield

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nytimes/config/stylesheet/app_color.dart';

class AppFont {
  AppFont._();

  static TextStyle titleLarge = large.copyWith(
      fontSize: font_size_xl, letterSpacing: letter_spacing_none);

  static TextStyle titleMedium = medium.copyWith(
      fontSize: font_size_l, letterSpacing: letter_spacing_half);

  static TextStyle titleSmall = regular.copyWith(
      fontSize: font_size_m, letterSpacing: letter_spacing_half);

  static TextStyle bodyLarge =
      large.copyWith(fontSize: font_size_m, letterSpacing: letter_spacing_none);

  static TextStyle bodyMedium = medium.copyWith(
      fontSize: font_size_r, letterSpacing: letter_spacing_half);

  static TextStyle bodySmall = regular.copyWith(
      fontSize: font_size_s, letterSpacing: letter_spacing_half);

  static TextStyle button = medium.copyWith(
      fontSize: font_size_r, letterSpacing: letter_spacing_half);

  static ButtonStyle buttonMedium = TextButton.styleFrom(
      foregroundColor: AppColor.primaryBlue,
      backgroundColor: Colors.transparent,
      textStyle: button);

  static const String font_family = 'Avenir';

  static const double font_size_xs = 11;
  static const double font_size_s = 12;
  static const double font_size_r = 14;
  static const double font_size_m = 16;
  static const double font_size_l = 18;
  static const double font_size_xl = 22;
  static const double font_size_xxl = 24;

  static const double letter_spacing_full = 0.5;
  static const double letter_spacing_half = 0.25;
  static const double letter_spacing_none = 0;

  static const TextStyle regular =
      TextStyle(fontFamily: font_family, fontWeight: FontWeight.normal);

  static const TextStyle medium =
      TextStyle(fontFamily: font_family, fontWeight: FontWeight.w600);

  static const TextStyle large =
      TextStyle(fontFamily: font_family, fontWeight: FontWeight.w700);
}
