import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/constants/app_colors.dart';
import 'package:flutter_ui_sample/constants/app_fonts.dart';
import 'package:flutter_ui_sample/presentation/widgets/CachedImage.dart';

import '../../constants/AppSpacing.dart';
import '../../domain/models/ThemeInteriorModel.dart';
import 'my_text.dart';

class ThemeListItem extends StatelessWidget {
  final ThemeInteriorModel themeInteriorModel;
  final VoidCallback onTap;
  final bool isDataLoaded;

  const ThemeListItem({
    super.key,
    required this.themeInteriorModel,
    required this.onTap,
    required this.isDataLoaded,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Padding(
      padding: EdgeInsets.only(
        left: isArabic ? 5.0 : AppValues.appValue_20,
        right: isArabic ? AppValues.appValue_20 : 5.0,
        top: AppValues.appValue_30,
        bottom: AppValues.appValue_20,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: AppValues.appValue_200,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(AppValues.appValue_30),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyColor,
                blurRadius: 13,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppValues.appValue_30),
                  ),
                  child: CachedImage(
                    fit: BoxFit.fill,
                    imageUrl: themeInteriorModel.imageUrl!,
                    width: AppValues.appValue_200,
                    topLeftRadius: AppValues.appValue_30,
                    topRightRadius: AppValues.appValue_30,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(AppValues.appValue_30),
                  child: MyText(
                    themeInteriorModel.themeName!,
                    style: TextStyle(
                      fontSize: FontSizes.headingMediumFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
