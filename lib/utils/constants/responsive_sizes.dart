import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveSize {
  static double get h => ScreenUtil().scaleHeight;
  static double get w => ScreenUtil().scaleWidth;
  static double setWidth(double size) => ScreenUtil().setWidth(size);
  static double setHeight(double size) => ScreenUtil().setHeight(size);

  // Access the screen util's setSp method for responsive font sizes
  static double setSp(double fontSize) => ScreenUtil().setSp(fontSize);
}

final screenPadding = ResponsiveSize.w * 18;
