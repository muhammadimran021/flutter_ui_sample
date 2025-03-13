import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/domain/models/TopRatedMoviesRootModel.dart';
import 'package:flutter_ui_sample/presentation/screens/movie_detail_page/movie_detail_page.dart';
import 'package:go_router/go_router.dart';

import '../screens/main_page/main_page.dart';
import '../screens/movie_detail_page/movie_detail_cubit.dart';
import '../screens/splash_page/splash_page.dart';
import '../screens/theme_detail_page/theme_detail_page.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final route = GoRouter(
  initialLocation: AppRoutes.splashPage,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: AppRoutes.splashPage,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute
      (
        path: AppRoutes.mainPage, builder: (context, state) => MainPage()),
    GoRoute(
      path: AppRoutes.themeDetailPage,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => ThemeDetailPage(),
    ),
    GoRoute(
        path: '${AppRoutes.movieDetailPage}:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final int id = int.tryParse(state.pathParameters['id'] ?? "0") ?? 0;
          final movie = Result.fromJson(state.extra as Map<String, dynamic>);
          return MovieDetailPage(movieId: id, movie: movie);
        }
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
  ]
  ,
);
