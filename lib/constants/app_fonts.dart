import 'dart:ui';

import 'package:flutter/foundation.dart';

class ButtonSizes {
  static double? buttonHeight = 45; // last was 70
}


class FontWeights {
  static FontWeight boldFontWeight = FontWeight.w800;
  static FontWeight fontWeight700 = FontWeight.w700;
  static FontWeight semiBoldFontWeight = FontWeight.w600;
  static FontWeight mediumFontWeight = FontWeight.w500;
  static FontWeight normalFontWeight = FontWeight.w400;
}

class FontSizes {
  ///--------------Heading Font Size---------------
  static double? maxHeadingLargeFont = 36;
  static double? headingLargeFont = 20;

  //26
  static double? headingMediumFont = 15;

  //23
  static double? headingSmallFont = 12;


  /// app body fonts
  static double? bodyNormalFont = 16;

  static getFont({required final double web, required final double app}) =>
      kIsWeb ? web : app;
}
