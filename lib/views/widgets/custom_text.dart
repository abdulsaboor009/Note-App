import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  String? text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  TextAlign? textAlign;
  double? letterSpacing;
  Paint? foreground;
  double? height;
  bool underLineText;
  TextWidget(
      {super.key,
      this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textAlign = TextAlign.start,
      this.letterSpacing,
      this.foreground,
      this.height,
      this.underLineText = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text!,
      style: GoogleFonts.nunito(
          height: height,
          foreground: foreground,
          letterSpacing: letterSpacing,
          fontSize: fontSize!,
          fontWeight: fontWeight,
          color: color,
          decoration:
              underLineText ? TextDecoration.underline : TextDecoration.none,
          decorationColor: color),
    );
  }
}

// ignore: must_be_immutable
class LimitedLinesText extends StatelessWidget {
  String? text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  TextAlign? textAlign;
  double? letterSpacing;
  Paint? foreground;
  double? height;
  bool underLineText;
  int maxLine;
  LimitedLinesText(
      {super.key,
      this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textAlign = TextAlign.start,
      this.letterSpacing,
      this.foreground,
      this.height,
      this.underLineText = false,
      this.maxLine = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text!,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.nunito(
          height: height,
          foreground: foreground,
          letterSpacing: letterSpacing,
          fontSize: fontSize!,
          fontWeight: fontWeight,
          color: color,
          decoration:
              underLineText ? TextDecoration.underline : TextDecoration.none,
          decorationColor: color),
    );
  }
}
