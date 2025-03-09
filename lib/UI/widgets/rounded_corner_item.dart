import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/constants/AppSpacing.dart';
import 'package:flutter_ui_sample/constants/app_colors.dart';
import 'package:flutter_ui_sample/constants/app_fonts.dart';
import 'package:redacted/redacted.dart';

import 'my_text.dart';

class RoundedCornerItem extends StatelessWidget {
  final String filterListItem;
  final int index;
  final VoidCallback onTap;
  final bool isLoading;

  const RoundedCornerItem({
    super.key,
    required this.filterListItem,
    required this.index,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    // Define the border style once
    final borderColor =
        index == 0 ? AppColors.blackColor : AppColors.greyBorderColor;
    final borderWidth = index == 0 ? 1.0 : 1.2;

    // Define the padding outside the widget tree to avoid recomputation
    final EdgeInsets padding = EdgeInsets.only(
      left: isArabic ? (index == 0 ? 10.0 : 10.0) : (index == 0 ? 20.0 : 0.0),
      right: isArabic ? (index == 0 ? 20.0 : 0.0) : (index == 0 ? 10.0 : 10.0),
    );

    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(AppValues.appValue_20),
          ),
          child: MyText(
            filterListItem,
            style: TextStyle(fontSize: FontSizes.headingSmallFont),
          ),
        )/*.redacted(context: context, redact: isLoading),*/
      ),
    );
  }
}
