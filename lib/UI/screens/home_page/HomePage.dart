import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../constants/AppSpacing.dart';
import '../../../constants/AppText.dart';
import '../../../constants/app_fonts.dart';
import '../../../routes/app_routes.dart';
import '../../shimmers/DynamicShimmer.dart';
import '../../widgets/designers_item.dart';
import '../../widgets/my_text.dart';
import '../../widgets/rounded_corner_item.dart';
import '../../widgets/theme_list_item.dart';
import 'home_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);

    Future.microtask(() async {
      await provider.fetchAndActivate();
      provider.getCategories();
      provider.getThemesItems();
      provider.getDesigners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _homePageView(context);
  }
}

Widget _homePageView(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppValues.appValue_20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.appValue_20),
          child: Row(
            children: [
              Expanded(
                child: MyText(
                  AppText.toolbarTitle,
                  style: TextStyle(
                    fontSize: FontSizes.maxHeadingLargeFont,
                    fontWeight: FontWeights.boldFontWeight,
                  ),
                ),
              ),
              Icon(Icons.menu, size: 35),
            ],
          ),
        ),
        SizedBox(height: AppValues.appValue_20),
        SizedBox(height: 40, child: _categoriesList(context)),
        SizedBox(height: 360, child: _themesList(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.appValue_20),
          child: MyText(
            AppText.designers_near_you,
            style: TextStyle(
              fontSize: FontSizes.headingLargeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: AppValues.appValue_20),
        SizedBox(height: 75, child: _designersList(context)),
      ],
    ),
  );
}

Widget _categoriesList(BuildContext context) {
  return Consumer<HomeProvider>(
    builder: (context, provider, _) {
      if (!provider.isCategoriesLoading) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return RoundedCornerItem(
              filterListItem: provider.categories[index],
              index: index,
              onTap: () {},
              isLoading: true,
            );
          },
          itemCount: provider.categories.length,
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: const DynamicShimmer(
          width: 80,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      );
    },
  );
}

Widget _themesList(BuildContext context) {
  return Consumer<HomeProvider>(
    builder: (context, provider, widget) {
      if (!provider.isThemeItemsLoading) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ThemeListItem(
              themeInteriorModel: provider.themesList[index],
              onTap: () => context.go(AppRoutes.themeDetailPage),
              isDataLoaded: provider.isThemeItemsLoading,
            );
          },
          itemCount: provider.themesList.length,
        );
      }
      return Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20.0,
          bottom: 30,
        ),
        child: DynamicShimmer(
          width: AppValues.appValue_200,
          height: 300,
          spacing: 20,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      );
    },
  );
}

Widget _designersList(BuildContext context) {
  return Consumer<HomeProvider>(
    builder: (context, provider, widget) {
      if (!provider.isDesignerLoading) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return DesignersItem(designersList: provider.designersList[index]);
          },
          itemCount: provider.designersList.length,
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: const DynamicShimmer(
          width: 75,
          height: 75,
          spacing: 20,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      );
    },
  );
}
