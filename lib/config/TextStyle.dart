// ignore_for_file: file_names, overridden_fields, annotate_overrides

import 'package:flutter/material.dart';

class TextStyleRegullarLight extends TextStyle {
  @override
  final Color color;
  final double size;
  final String fontFamily;

  const TextStyleRegullarLight({
    required this.size,
    this.color = Colors.white,
    this.fontFamily = 'Poppins-Regular',
  }) : super(
          color: color,
          fontSize: size,
          fontFamily: fontFamily,
        );
}

class TextStyleBoldLight extends TextStyle {
  @override
  final Color color;
  final double size;
  final String fontFamily;

  const TextStyleBoldLight({
    required this.size,
    this.color = Colors.white,
    this.fontFamily = 'Poppins-Bold',
  }) : super(
          color: color,
          fontSize: size,
          fontFamily: fontFamily,
        );
}

class TextStyleSemiBoldLight extends TextStyle {
  @override
  final Color color;
  final double size;
  final String fontFamily;

  const TextStyleSemiBoldLight({
    required this.size,
    this.color = Colors.white,
    this.fontFamily = 'Poppins-SemiBold',
  }) : super(
          color: color,
          fontSize: size,
          fontFamily: fontFamily,
        );
}

class TextStyleSemiBoldNoColor extends TextStyle {
  final double size;
  final String fontFamily;

  const TextStyleSemiBoldNoColor({
    required this.size,
    this.fontFamily = 'Poppins-SemiBold',
  }) : super(
          fontSize: size,
          fontFamily: fontFamily,
        );
}
