import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/domain/models/FirebaseRemoteConfigs.dart';
import 'package:flutter_ui_sample/presentation/widgets/CachedImage.dart';

import '../../constants/AppSpacing.dart';
import '../../constants/app_colors.dart';
import '../../domain/models/TopRatedMoviesRootModel.dart';
import 'my_text.dart';

class MoviesCardLarge extends StatelessWidget {
  final Result movie;
  final void Function(String id) onTap;

  const MoviesCardLarge({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return GestureDetector(
      onTap: () {
        onTap(movie.id.toString());
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: isArabic ? 5.0 : AppValues.appValue_20,
          right: isArabic ? AppValues.appValue_20 : 5.0,
          top: AppValues.appValue_30,
          bottom: AppValues.appValue_20,
        ),
        child: SizedBox(
          width: 250,
          height: 500,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: CachedImage(
                      fit: BoxFit.fill,
                      imageUrl:
                          "${FirebaseRemoteConfigs.instance.moviesImageBaseUrl!}/${movie.posterPath!}",
                      topLeftRadius: AppValues.appValue_30,
                      topRightRadius: AppValues.appValue_30,
                      bottomLeftRadius: AppValues.appValue_30,
                      bottomRightRadius: AppValues.appValue_30,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      MyText(
                        "${movie.title}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 30),
                          MyText(
                            "${movie.voteCount}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
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
