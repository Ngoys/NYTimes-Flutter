// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class AppFont {
  AppFont._();

  static TextStyle titleLarge = _regular.copyWith(
      fontSize: _font_size_xl, letterSpacing: _letter_spacing_full);

  static TextStyle titleMedium = _regular.copyWith(
      fontSize: _font_size_l, letterSpacing: _letter_spacing_half);

  static TextStyle titleSmall = _regular.copyWith(
      fontSize: _font_size_m, letterSpacing: _letter_spacing_half);

  static TextStyle bodyLarge = _regular.copyWith(
      fontSize: _font_size_m, letterSpacing: _letter_spacing_full);

  static TextStyle bodyMedium = _regular.copyWith(
      fontSize: _font_size_r, letterSpacing: _letter_spacing_half);

  static TextStyle bodySmall = _regular.copyWith(
      fontSize: _font_size_s, letterSpacing: _letter_spacing_half);

  static TextStyle button = _medium.copyWith(
      fontSize: _font_size_r, letterSpacing: _letter_spacing_half);

  static TextStyle label = _regular.copyWith(
      fontSize: _font_size_xs, letterSpacing: _letter_spacing_full);

  static TextStyle dialog_title = _regular.copyWith(
      fontSize: _font_size_xxl, letterSpacing: _letter_spacing_full);

  static TextStyle bottom_sheet_title = _regular.copyWith(
      fontSize: _font_size_xl, letterSpacing: _letter_spacing_half);

  static const String _font_family = 'Avenir';

  static const double _font_size_xs = 11;
  static const double _font_size_s = 12;
  static const double _font_size_r = 14;
  static const double _font_size_m = 16;
  static const double _font_size_l = 18;
  static const double _font_size_xl = 22;
  static const double _font_size_xxl = 24;

  static const double _letter_spacing_full = 0.5;
  static const double _letter_spacing_half = 0.25;

  static const TextStyle _regular =
      TextStyle(fontFamily: _font_family, fontWeight: FontWeight.normal);

  static const TextStyle _medium =
      TextStyle(fontFamily: _font_family, fontWeight: FontWeight.w500);
}
