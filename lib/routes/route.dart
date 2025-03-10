import 'package:flutter/cupertino.dart';
import 'package:flutter_ui_sample/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../UI/screens/main_page/main_page.dart';
import '../UI/screens/theme_detail_page/theme_detail_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final route = GoRouter(
  initialLocation: AppRoutes.mainPage,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(path: AppRoutes.mainPage, builder: (context, state) => MainPage()),
    GoRoute(
      path: AppRoutes.themeDetailPage,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => ThemeDetailPage(),
    ),

    /* ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return MainPage(child: child);
      },
      routes: [
        */
    /*GoRoute(
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
        ),*/
    /*
        GoRoute(
          path: AppRoutes.themeDetailPage,
          builder: (context, state) => ThemeDetailPage(),
        ),
      ],
    ),*/
  ],
);
