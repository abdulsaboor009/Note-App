import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notebox/utils/constants/app_colors.dart';
import 'package:notebox/utils/constants/app_font_weights.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';

Widget customTextfield({
  TextEditingController? controller,
  double fontsize = 14,
  double hintfontsize = 14,
  FontWeight fontWeight = FontWeight.w500,
  String? hint,
  Function? onFieldSubmitted,
  Function? onChanged,
  bool onChangedbool = false,
  String? Function(String?)? onValidator,
  TextInputType? keyboardType,
  int minLines = 1,
  int? maxLines,
  Color fillColor = AppColors.textFieldFillColor,
  double borderWidth = 0,
  Color borderColor = AppColors.textFieldBorderColor,
  double borderRadius = 0,
  Color hintTextColor = AppColors.textFieldhintColor,
  Color textColor = AppColors.textFieldtextColor,
  bool enabled = true,
  double wordVirticleSpacing = 1.4,
  double textHorizentalSpacing = 0,
  List<TextInputFormatter>? inputFormatters,
  FocusNode? focusNode,
}) {
  return TextFormField(
    enabled: enabled,
    validator: onValidator,
    onChanged: (v) {
      onChangedbool ? onChanged!(v) : (v) {};
    },
    minLines: minLines,
    maxLines: maxLines,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    focusNode: focusNode,
    style: GoogleFonts.nunito(
        height: wordVirticleSpacing,
        fontSize: ResponsiveSize.setSp(fontsize),
        color: textColor,
        fontWeight: AppFontweight.medium.font),
    controller: controller,
    textAlign: TextAlign.start,
    decoration: InputDecoration(
      contentPadding:
          EdgeInsets.symmetric(horizontal: textHorizentalSpacing, vertical: 5),
      hintStyle: GoogleFonts.nunito(
          fontSize: ResponsiveSize.setSp(hintfontsize),
          color: hintTextColor,
          fontWeight: AppFontweight.medium.font),
      hintText: hint,
      fillColor: fillColor,
      filled: true,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor, width: borderWidth),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor, width: borderWidth),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: borderWidth)),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide:
            BorderSide(color: AppColors.redColor.withOpacity(0.5), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      errorStyle: GoogleFonts.nunito(
          fontSize: ResponsiveSize.setSp(fontsize - 2),
          color: AppColors.redColor,
          fontWeight: AppFontweight.medium.font),
    ),
  );
}
