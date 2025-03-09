import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/constants/app_fonts.dart';

import '../../../constants/AppSpacing.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/my_text.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final String local = context.locale.languageCode;
    if (local == 'ar') {
      isSwitched = true;
    } else {
      isSwitched = false;
    }
    return Padding(
      padding: EdgeInsets.all(AppValues.appValue_10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(AppValues.appValue_10),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor,
                  blurRadius: 13,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: AppValues.appValue_10,
                right: AppValues.appValue_10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    "Change Language",
                    style: TextStyle(fontSize: FontSizes.bodyNormalFont),
                  ),
                  Row(
                    children: [
                      MyText("English"),
                      SizedBox(width: AppValues.appValue_10),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) async {
                          if (value == true) {
                            await context.setLocale(Locale('ar'));
                          } else {
                            await context.setLocale(Locale('en'));
                          }
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor: Colors.blue,
                        inactiveThumbColor: AppColors.grey,
                      ),
                      SizedBox(width: AppValues.appValue_10),
                      MyText("Arabic"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
