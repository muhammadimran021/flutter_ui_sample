import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/presentation/widgets/CachedImage.dart';

import '../../constants/AppSpacing.dart';
import '../../constants/app_colors.dart';

class DesignersItem extends StatelessWidget {
  final String designersList;

  const DesignersItem({super.key, required this.designersList});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Padding(
      padding: EdgeInsets.only(
        left: isArabic ? 0.0 : AppValues.appValue_20,
        right: isArabic ? AppValues.appValue_20 : 0.0,
      ),
      child: Container(
        width: 75, // Directly setting width instead of using SizedBox
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppValues.appValue_20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppValues.appValue_20),
          child: CachedImage(
            fit: BoxFit.cover,
            imageUrl: designersList,
          ),
        ),
      ),
    );
  }
}
