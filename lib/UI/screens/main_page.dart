import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../widgets/bottom_navigation_item.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavigationItem(
              icon: Icons.home_filled,
              onTap: () {
                context.go(AppRoutes.homepage);
              },
            ),
            BottomNavigationItem(
              icon: Icons.search,
              onTap: () {
                context.go(AppRoutes.searchPage);
              },
            ),
            BottomNavigationItem(
              icon: Icons.card_travel,
              onTap: () {
                context.go(AppRoutes.userAccountPage);
              },
            ),
            BottomNavigationItem(
              icon: Icons.person,
              onTap: () {
                context.go(AppRoutes.userProfilePage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
