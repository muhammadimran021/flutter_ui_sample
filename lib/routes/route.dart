import 'package:flutter/cupertino.dart';
import 'package:flutter_ui_sample/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../UI/screens/home_page/HomePage.dart';
import '../UI/screens/main_page.dart';
import '../UI/screens/profile/user_profile_page.dart';
import '../UI/screens/search_page/search_page.dart';
import '../UI/screens/theme_detail_page/theme_detail_page.dart';
import '../UI/screens/user_account_page/user_account_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final route = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return MainPage(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.homepage,
          pageBuilder: (context, state) => NoTransitionPage(child: Homepage()),
          routes: [
            GoRoute(
              path: AppRoutes.themeDetailPage,
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => ThemeDetailPage(),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.searchPage,
          pageBuilder:
              (context, state) => NoTransitionPage(child: SearchPage()),
        ),
        GoRoute(
          path: AppRoutes.userAccountPage,
          pageBuilder:
              (context, state) => NoTransitionPage(child: UserAccountPage()),
        ),
        GoRoute(
          path: AppRoutes.userProfilePage,
          pageBuilder:
              (context, state) => NoTransitionPage(child: UserProfilePage()),
        ),
      ],
    ),
  ],
);
