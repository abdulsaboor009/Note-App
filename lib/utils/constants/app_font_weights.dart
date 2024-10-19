// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum AppFontweight {
  thin,
  normal,
  medium,
  semi_bold,
  bold,
  extra_bold,
  very_extra_bold,
}

extension FontWeightExtension on AppFontweight {
  FontWeight get font {
    switch (this) {
      case AppFontweight.thin:
        return FontWeight.w300;
      case AppFontweight.normal:
        return FontWeight.w400;
      case AppFontweight.medium:
        return FontWeight.w500;
      case AppFontweight.semi_bold:
        return FontWeight.w600;
      case AppFontweight.bold:
        return FontWeight.w700;
      case AppFontweight.extra_bold:
        return FontWeight.w800;
      case AppFontweight.very_extra_bold:
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }
}
