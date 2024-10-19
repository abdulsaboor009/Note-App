import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_font_weights.dart';
import '../../utils/constants/responsive_sizes.dart';
import 'custom_text.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double borderRadius;
  final double height;
  final double width;
  final Color buttonColor;
  final String centerContent;
  final double borderwidth;
  final Color borderColor;
  final Color textColor;
  final double fontSize;
  final Widget icon;
  const CustomButton({
    super.key,
    this.onPressed,
    this.borderRadius = 40,
    this.height = 50,
    this.width = double.infinity,
    this.buttonColor = AppColors.primaryColor,
    required this.centerContent,
    this.borderwidth = 0,
    this.borderColor = Colors.transparent,
    this.textColor = AppColors.backgroundColor,
    this.fontSize = 16,
    this.icon = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      clipBehavior: Clip.none,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      height: ResponsiveSize.h * height,
      minWidth: width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: null,
      child: Container(
        height: ResponsiveSize.h * height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonColor,
          border: Border.all(color: borderColor, width: borderwidth),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              TextWidget(
                fontSize: ResponsiveSize.setSp(fontSize),
                fontWeight: AppFontweight.bold.font,
                text: centerContent,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
