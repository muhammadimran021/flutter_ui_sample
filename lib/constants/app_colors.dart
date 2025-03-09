import 'package:flutter/material.dart';

class AppColors {
  static const secondaryColor = Color(0xFF7541BA);
  static const whiteColorBg = Color(0xFFFFFFFF);
  static const whiteColor = Colors.white;
  static const splashColor = Color(0xFF050708);
  static const blackColor = Color(0xff000000);
  static const blackLabelColor = Color(0xff1F1F1F);
  static const greyColor = Color(0xFFECF0F1);
  static const scaffoldColor = Color(0xFFF7F8F8);
  static const greyTextColor = Color(0xFF5B6268);
  static const greyBorderColor = Color(0xFFECF0F1);
  static const greyLabelTextColor = Color(0xFF838E8F);
  static const availabilityColor = Color(0xFF24C081);
  static const ratingColor = Color(0xFFF1B826);
  static const rangeColor = Color(0xFFAAAAAA);
  static const userPreferenceBackground = Color(0xFFD9D9D9);
  static const radioDisabledColor = Color(0xFF84848C);
  static const grey = Colors.grey;
  static const greyColorLight = Color(0xFFF6F8F8);
  static const textGeryColor500 = Color(0xFF5B6268);
  static const textGreyColor400 = Color(0xFF6E7681);
  static const textGreyColor600 = Color(0xFF313437);
  static const textGreyColor300 = Color(0xFF838E8F);
  static LinearGradient shadowOverlay = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Colors.black.withOpacity(0.95),
      Colors.black.withOpacity(0.6),
      Colors.black.withOpacity(0.3),
      Colors.black.withOpacity(0),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );
  static LinearGradient topShadowOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.black.withOpacity(0.9),
      Colors.black.withOpacity(0.6),
      Colors.black.withOpacity(0.3),
      Colors.black.withOpacity(0),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  static LinearGradient dialogLinearGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [whiteColor, Color(0xFF72F1BE)]);
  static const dividerColorLight = Color(0xFFECECEC);
  static const dividerColorDark = Color(0xFF5A5A5A);
  static const cartCounterButtonColor = Color(0xFF9CA3AF);
  static const dropDownButtonTextColor = Color(0xFF6B7280);
  static const buttonBorderColor = Color(0xFFE4E4E7);
  static const cartBadgeColor = Color(0xFF4862EE);
  static const emailFontColor = Color(0xFFF5F5F5);
  static const redColor = Color(0xFFF35252);

  static Color shimmerBaseColor = Colors.grey[300] ?? Colors.grey;
  static Color shimmerHighlightColor = Colors.grey[400] ?? Colors.grey;
}

